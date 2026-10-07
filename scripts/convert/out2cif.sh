#!/usr/bin/env bash
# 使用 Multiwfn 批量将 OUT 文件转换为 CIF。
# I/O: *.out -> *.cif
# Requires: Multiwfn
# Note: 适用于 Multiwfn 能识别的输出文件。

icc=0
nfile=`ls *.out|wc -l`
for inf in *.out
do
((icc++))
echo Converting ${inf} to ${inf//out/cif} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
100
2
33
${inf//out/cif}
0
q
EOF
done