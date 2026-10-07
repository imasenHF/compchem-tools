#!/usr/bin/env bash
# 使用 Multiwfn 从 Gaussian 输出批量生成红外光谱线谱与展宽曲线。
# I/O: *.log -> 每体系 *_line.txt / *_curve.txt
# Requires: Multiwfn
# Note: 频率范围与展宽参数写在菜单输入中。

rm -f Read.txt
rm -f done
ini=$(date +%s)
icc=0
nfile=`ls *.log|wc -l`
for inf in *.log
do
start_time=$(date +%s)
((icc++))
echo Processed IR spectra for ${inf//.log} ... \($icc of $nfile\) >> Read.txt
Multiwfn ${inf} << EOF
11
1
3
0,120,0.1
2
-3
q
EOF
mkdir ${inf//.log}
mv spectrum_curve.txt ./${inf//.log}/${inf//.log/_curve.txt}
mv spectrum_line.txt ./${inf//.log}/${inf//.log/_line.txt}
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
