#!/usr/bin/env bash
# 调用 Shermo 批量计算 ORCA 输出的 Gibbs 热校正。
# I/O: *.out -> getGall.txt
# Requires: Shermo.exe
# Note: 温度等参数使用 Shermo 默认值/脚本设置。

rm -f getGall.txt
for inf in *.out
do
echo Processing ${inf} ...
Gcorr=$(Shermo.exe ${inf} | grep "Thermal correction to G:" | cut -d: -f 2) >> getGall.txt  # -T 293.15,358.15,10 
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