#!/usr/bin/env bash
# 对 ORCA Molden 波函数批量执行 Multiwfn IGMH/相互作用分析流程。
# I/O: *.molden -> 每体系子目录
# Requires: Multiwfn
# Note: 与 getIGMH.sh 使用相同菜单流程，保留作为 ORCA 命名入口。

rm -f Read.txt
rm -f done
ini=$(date +%s)
icc=0
nfile=`ls *.molden|wc -l`
for inf in *.molden
do
start_time=$(date +%s)
((icc++))
echo Processed IRI Analysis for ${inf//.molden} ... \($icc of $nfile\) >> Read.txt
Multiwfn ${inf} << EOF
20
11
2
1-103
c
11
1-103
3.5 A
0.15
2
3
0
0
q
EOF
mkdir ${inf//.molden}
mv *.cub ./${inf//.molden}
mv *.txt ./${inf//.molden}
end_time=$(date +%s)
cost_time=$(($end_time-$start_time))
echo "Cost time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s
" >> Read.txt
done
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" >> Read.txt

echo > done
