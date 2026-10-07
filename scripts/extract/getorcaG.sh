#!/usr/bin/env bash
# 从 ORCA 输出批量提取 Final Gibbs free energy 与 G-E(el)。
# I/O: *.out -> orcaG.txt
# Requires: grep
# Note: 基于 ORCA 固定文本匹配。

rm -f orcaG.txt
for inf in *.out
do
echo Processing ${inf} ...
orcaG=$(cat ${inf} | grep "Final Gibbs free energy")
orcaG_E=$(cat ${inf} | grep "G-E(el)")
echo -e "${inf//.out}\t${orcaG}\t${orcaG_E}" |tee -a orcaG.txt
echo ${inf} done!!!
done

echo getTotalG done!!!