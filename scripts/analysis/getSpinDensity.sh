#!/usr/bin/env bash
# 从 Gaussian fchk 批量生成自旋密度相关 cube/图像/文本。
# I/O: *.fchk -> 每体系子目录
# Requires: Multiwfn
# Note: 会移动当前目录中匹配的 *.cub、*.png 和 output.txt。

rm -f Read.txt
ini=$(date +%s)
icc=0
nfile=`ls *.fchk|wc -l`
for inf in *.fchk
do
start_time=$(date +%s)
((icc++))
echo Processed Spin Density Analysis for ${inf//.fchk} ... \($icc of $nfile\) |tee Read.txt
Multiwfn ${inf} << EOF > /dev/null
5
5
3
2
1
3
0
q
EOF
mkdir ${inf//.fchk}
echo "Finish Spin Density Analysis for ..." |tee Read.txt
mv *.cub ./${inf//.fchk}
echo "mv ${inf//fchk/cub} to ${inf//.fchk}" |tee Read.txt
mv *.png ./${inf//.fchk}
echo "mv ${inf//fchk/png} to ${inf//.fchk}" |tee Read.txt
mv output.txt ./${inf//.fchk}
echo "mv ${inf//fchk/txt} to ${inf//.fchk}" |tee Read.txt
end_time=$(date +%s)
cost_time=$(($end_time-$start_time))
echo "Cost time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s
" |tee Read.txt
done
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" |tee Read.txt
