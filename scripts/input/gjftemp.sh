#!/usr/bin/env bash
# 批量重写 GJF 计算头并保留原几何部分。
# I/O: *.gjf -> 原地修改
# Requires: sed
# Note: 计算级别、资源、总电荷和多重度均为固定示例；会覆盖文件。

#log2gjf.sh
for inf in *.gjf
do
echo Processing ${inf} ...
cat ${inf} > ${inf//.gjf/_org.gjf}
echo "%nprocshared=64
%mem=100GB
%chk=${inf//.gjf/.chk}
#p b3lyp/6-31g** opt scrf em=gd3bj

${inf//.gjf/}

  0  2" > ${inf}
sed '1,8d' ${inf//.gjf/_org.gjf} >> ${inf}
#cat ${inf} > ${inf//.gjf/_org.gjf}
#rm -f ${inf}
rm -f ${inf//.gjf/_org.gjf}
echo ${inf} done!!!
done