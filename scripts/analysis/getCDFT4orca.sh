#!/usr/bin/env bash
# 基于 N、N+1、N-1 波函数文件调用 Multiwfn 计算概念 DFT 描述符。
# I/O: *_N.wfn + 对应 N±1 文件 -> CDFT/
# Requires: Multiwfn
# Note: 面向 ORCA 工作流的 WFN 文件命名约定。

ulimit -s unlimited
export OMP_STACKSIZE=1000M

rm -f Read.txt
ini=$(date +%s)
icc=0
nfile=`ls *_N.wfn|wc -l`
for inf in *_N.wfn
do
start_time=$(date +%s)
((icc++))
echo Processed CDFT Analysis for ${inf//_N.wfn} ... \($icc of $nfile\) |tee -a Read.txt
Multiwfn ${inf} << EOF
22
2
${inf}
${inf//N.wfn/N+1.wfn}
${inf//N.wfn/N-1.wfn}
3
${inf}
${inf//N.wfn/N+1.wfn}
${inf//N.wfn/N-1.wfn}
3


5
6
7
8
0
0
q
EOF

if [ ! -d "CDFT" ]; then mkdir CDFT; fi
mv -f CDFT.txt ./CDFT/${inf//_N.wfn/_CDFT.txt}
for file in *.cub; do mv -f ${file} ./CDFT/${inf//_N.wfn}_${file}; done

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