#!/usr/bin/env bash
# 从 NBO .31 文件批量导出指定轨道的 cube 文件。
# I/O: *.31 -> 每体系子目录
# Requires: Multiwfn
# Note: 第一个命令行参数用于指定轨道。

ulimit -s unlimited
export OMP_STACKSIZE=1000M

rm -f Read.txt
ini=$(date +%s)
icc=0
nfile=`ls *.31|wc -l`
for inf in *.31
do
start_time=$(date +%s)
((icc++))
echo Generate orbit cube files for ${inf//.31} ... \($icc of $nfile\) |tee -a Read.txt
Multiwfn ${inf} << EOF > /dev/null
37
200
3
$1
3
1
0
q
EOF
mkdir ${inf//.31}
mv *.cub ./${inf//.31}
done
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" |tee -a Read.txt