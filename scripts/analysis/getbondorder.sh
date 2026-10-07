#!/usr/bin/env bash
# 使用 Multiwfn 对 Molden 波函数批量计算键级矩阵。
# I/O: *.molden -> *_bndmat.txt
# Requires: Multiwfn
# Note: 输出依赖 Multiwfn bndmat.txt。

ulimit -s unlimited
export OMP_STACKSIZE=1000M

rm -f Bond_order_analysis.txt
rm -f bndmat.txt
ini=$(date +%s)
icc=0
nfile=`ls *.molden|wc -l`
for inf in *.molden
do
start_time=$(date +%s)
((icc++))
echo Start Bond order analysis for ${inf//.molden} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF #> /dev/null
9
1
y
0
q
EOF
echo "Bond order analysis for ${inf//.molden}"
cat bndmat.txt >> ${inf//.molden/_bndmat.txt}
rm -f bndmat.txt
echo " *****************************************************************************

" >> ${inf//.molden/_bndmat.txt}

done
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s"