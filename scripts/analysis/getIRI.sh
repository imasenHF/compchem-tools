#!/usr/bin/env bash
# 使用 Multiwfn 对 Molden 波函数批量生成 IRI 相关 cube 数据。
# I/O: *.molden -> 每体系子目录
# Requires: Multiwfn
# Note: 菜单序列固定。

icc=0
nfile=`ls *.molden|wc -l`
for inf in *.molden
do
((icc++))
echo Processed IRI Analysis for ${inf//.molden} ... \($icc of $nfile\)
Multiwfn ${inf} << EOF > /dev/null
20
4
3
3
0
0
q
EOF
mkdir ${inf//.molden}
mv *.cub ./${inf//.molden}
done