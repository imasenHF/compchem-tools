#!/usr/bin/env bash
# 按片段定义对 Gaussian 激发态执行 hole–electron 分解分析。
# I/O: *.fchk + *.log + *_frag.txt -> *.txt
# Requires: Multiwfn
# Note: 默认处理 10 个激发态；片段定义文件名固定。

nstate=10
ini=$(date +%s)
icc=0
nfile=`ls *.fchk|wc -l`
for inf in *.fchk
do
rm -f ${inf//fchk/txt}
start_time=$(date +%s)
((icc++))
echo "
**********************************************************************
Processed Hole-electron analysis for ${inf//.fchk} ... ($icc of $nfile)
**********************************************************************" |tee -a ${inf//fchk/txt}
for ((i=1;i<=${nstate};i=i+1))
do
echo ${inf//.fchk}_state$i |tee -a ${inf//fchk/txt}
Multiwfn ${inf} << EOF > /dev/null
18
1
${inf//fchk/log}
$i
3
1
-1
0
${inf//.fchk/_frag.txt}
2
0
0
0
q
EOF

cat he_frag.txt >> ${inf//fchk/txt}
end_time=$(date +%s)
cost_time=$(($end_time-$start_time))
echo "State$i Cost time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s"
done
done

rm -f he_frag.txt
ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" |tee -a ${inf//fchk/txt}
