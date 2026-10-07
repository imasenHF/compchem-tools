#!/usr/bin/env bash
# 调用 Shermo 批量计算 Gaussian 频率输出的 Gibbs 热校正。
# I/O: *.log -> getGall.txt
# Requires: Shermo.exe
# Note: 温度与低频处理参数写在脚本中。

rm -f getGall.txt
for inf in *.log
do
echo Processing ${inf} ...
Gcorr=$(Shermo.exe ${inf} -ilowfreq 2 -T 293.15 | grep "Thermal correction to G:" | cut -d: -f 2) >> getGall.txt  # -T 293.15,358.15,10  -T 173,473,10
echo -e "${inf//.log}\t${Gcorr}" |tee -a  getGall.txt
if [ -f scan_UHG.txt ]; then
  cat scan_UHG.txt >> getGall.txt
fi
if [ -f scan_SCq.txt ]; then
  cat scan_SCq.txt >> getGall.txt
fi
rm -f scan_UHG.txt
rm -f scan_SCq.txt
echo ${inf} done!!!
done