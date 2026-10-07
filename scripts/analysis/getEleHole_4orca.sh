#!/usr/bin/env bash
# 对 ORCA 激发态结果批量执行 hole–electron 分析并整理 cube 文件。
# I/O: *.molden + 同名 *.out -> 每体系子目录
# Requires: Multiwfn
# Note: 当前脚本分析前 10 个激发态。

rm -f Read.txt
ini=$(date +%s)
icc=0
nfile=`ls *.molden|wc -l`
for inf in *.molden
do
start_time=$(date +%s)
((icc++))
echo "**********************************************************************" >> Read.txt
echo Processed Hole-electron analysis for ${inf//.molden} ... \($icc of $nfile\) |tee -a Read.txt
for ((i=1;i<=10;i=i+1))
do
echo "
Processed Hole-electron Analysis for State $i" >> Read.txt
Multiwfn ${inf} << EOF |tee ${inf//molden/txt}

18
1
${inf//molden/out}
1
$i

1
3
10
1
11
1
12
2
15
16
0
0
0
q
EOF
grep "Sr index" ${inf//molden/txt} |nl >> Read.txt
grep "D index" ${inf//molden/txt} |nl >> Read.txt
grep "RMSD of hole in" ${inf//molden/txt} |nl >> Read.txt
grep "RMSD of electron in" ${inf//molden/txt} |nl >> Read.txt
grep "H index" ${inf//molden/txt} |nl >> Read.txt
grep "t index" ${inf//molden/txt} |nl >> Read.txt
if [ ! -d ${inf//.molden} ]; then
mkdir ${inf//.molden}
fi
mv CDD.cub ./${inf//.molden}/CDD_$i.cub
mv Cele.cub ./${inf//.molden}/Cele_$i.cub
mv Chole.cub ./${inf//.molden}/Chole_$i.cub
mv electron.cub ./${inf//.molden}/electron_$i.cub
mv hole.cub ./${inf//.molden}/hole_$i.cub
mv Sr.cub ./${inf//.molden}/Sr_$i.cub
echo "move Cube file to ${inf//.molden}"
rm -f ${inf//molden/txt}
echo "delete ${inf//molden/txt}
"
done
echo
echo "Finish Hole-electron analysis for ${inf//.molden}" |tee -a Read.txt
end_time=$(date +%s)
cost_time=$(($end_time-$start_time))
echo "Cost time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s

" |tee -a Read.txt
done
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" |tee -a Read.txt
