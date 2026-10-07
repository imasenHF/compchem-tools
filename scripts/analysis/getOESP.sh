#!/usr/bin/env bash
# 对 Molden 波函数批量执行电子密度、静电势与分子表面相关分析。
# I/O: *.molden -> 每体系子目录
# Requires: Multiwfn
# Note: 与 ORCA/Molden 工作流配套。

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
echo Processed Electron Density and ESP Analysis for ${inf//.molden} ... \($icc of $nfile\) |tee -a Read.txt
Multiwfn ${inf} -ESPrhoiso 0.001 << EOF
5
1
3
2
0
5
12
1
2
0
q
EOF

if [ -n "$1" ]; then
if [ "$1" = "eV" ]; then
unit_convert=27.2114
elif [ "$1" = "kcal/mol" ]; then
unit_convert=627.51
elif [ "$1" = "kJ/mol" ]; then
unit_convert=2625.5
else
echo "!!! input error !!!"
fi
else
unit_convert=627.51
fi
Multiwfn totesp.cub << EOF
13
11
5
${unit_convert}
0
totesp.cub
-1
q
EOF

mv -f totesp.cub ESP.cub 

echo Processed  Molecular Surface Quantitative Analysis for ${inf//.molden} ... \($icc of $nfile\) |tee -a Read.txt

Multiwfn ${inf} << EOF
12
3
0.15
0
5
mol.pdb
6
2
-1
-1
q
EOF

mkdir ${inf//.molden}
for file in *.cub; do mv -f $file ./${inf//.molden}/${file%.cub}1.cub; done
mv -f surfanalysis.pdb ./${inf//.molden}
for file in *.pdb; do mv -f $file ./${inf//.molden}/${file%.pdb}1.pdb; done
end_time=$(date +%s)
cost_time=$(($end_time-$start_time))
echo "Cost time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s
" |tee -a Read.txt

ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" |tee -a Read.txt

done