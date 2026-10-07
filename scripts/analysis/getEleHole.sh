#!/usr/bin/env bash
# 对 Gaussian 激发态结果批量执行 hole–electron 分析并整理 cube 文件。
# I/O: *.fchk + 同名 *.log -> 每体系子目录
# Requires: Multiwfn
# Note: 当前脚本分析前 4 个激发态。

rm -f Read.txt
ini=$(date +%s)
icc=0
nfile=`ls *.fchk|wc -l`
for inf in *.fchk
do
start_time=$(date +%s)
((icc++))
echo "**********************************************************************" >> Read.txt
echo Processed Hole-electron analysis for ${inf//.fchk} ... \($icc of $nfile\) |tee -a Read.txt
for ((i=1;i<=4;i=i+1))
do
echo "
Processed Hole-electron Analysis for State $i" >> Read.txt
Multiwfn ${inf} << EOF |tee ${inf//fchk/txt}
18
1
${inf//fchk/log}
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
grep "Sr index" ${inf//fchk/txt} |nl >> Read.txt
grep "D index" ${inf//fchk/txt} |nl >> Read.txt
grep "RMSD of hole in" ${inf//fchk/txt} |nl >> Read.txt
grep "RMSD of electron in" ${inf//fchk/txt} |nl >> Read.txt
grep "H index" ${inf//fchk/txt} |nl >> Read.txt
grep "t index" ${inf//fchk/txt} |nl >> Read.txt
echo
echo "Finish Hole-electron analysis for ${inf//.fchk}" |tee -a Read.txt
if [ ! -d ${inf//.fchk} ]; then
mkdir ${inf//.fchk}
fi
mv CDD.cub ./${inf//.fchk}/CDD_$i.cub
mv Cele.cub ./${inf//.fchk}/Cele_$i.cub
mv Chole.cub ./${inf//.fchk}/Chole_$i.cub
mv electron.cub ./${inf//.fchk}/electron_$i.cub
mv hole.cub ./${inf//.fchk}/hole_$i.cub
mv Sr.cub ./${inf//.fchk}/Sr_$i.cub
echo "move Cube file to ${inf//.fchk}"
rm -f ${inf//fchk/txt}
echo "delete ${inf//fchk/txt}
"
done
echo
echo "Finish Hole-electron analysis for ${inf//.fchk}" |tee -a Read.txt
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