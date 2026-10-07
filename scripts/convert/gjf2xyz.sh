#!/usr/bin/env bash
# 使用 Multiwfn 批量将 GJF 转换为 XYZ。
# I/O: *.gjf -> *_EDAw.xyz
# Requires: Multiwfn
# Note: 保留历史输出后缀 _EDAw.xyz。

icc=0
nfile=`ls *.gjf|wc -l`
for inf in *.gjf
do
((icc++))
echo Converting ${inf} to ${inf//gjf/xyz} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
100
2
2
${inf//.gjf/_EDAw.xyz}
0
q
EOF
done