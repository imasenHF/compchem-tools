#!/usr/bin/env bash
# 从 Molden 波函数批量生成指定轨道的 cube 文件。
# I/O: *.molden -> cub/
# Requires: Multiwfn
# Note: 第一个命令行参数用于指定轨道。

ulimit -s unlimited
export OMP_STACKSIZE=1000M

rm -f Read.txt
ini=$(date +%s)
icc=0
nfile=`ls *.molden|wc -l`
for inf in *.molden
do
start_time=$(date +%s)
((icc++))
echo Generate orbit cube files for ${inf//.molden} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF #> /dev/null
200
3
$1
3
1
0
q
EOF
if [ ! -d "cub" ]; then
mkdir cub
fi
for file in *.cub
do
mv ${file} ./cub/${inf//.molden}_${file}
done
done
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s"