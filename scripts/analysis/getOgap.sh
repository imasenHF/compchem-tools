#!/usr/bin/env bash
# 从 Molden 波函数批量读取 Multiwfn 输出的轨道能级信息。
# I/O: *.molden -> HOMO_LUMO
# Requires: Multiwfn
# Note: 通过静默启动输出中的 eV 行提取。

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
Multiwfn ${inf} -isilent 0 << EOF > temp
0
q
EOF
echo Orbital Information for ${inf} ...
gap=$(cat temp | grep "eV")
echo -e "${inf//.log}\n$gap\n\n" |tee -a HOMO_LUMO
echo ${inf} done!!!
done
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" |tee -a Read.txt