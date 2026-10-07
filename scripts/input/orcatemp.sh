#!/usr/bin/env bash
# 生成固定 ORCA 模板，并通过 Multiwfn 从现有结构/波函数文件创建单点输入。
# I/O: *.fchk/*.log/*.out -> *_sp.inp
# Requires: Multiwfn
# Note: 方法与资源参数固定为示例，使用前必须核对。

echo "! wB97M-V def2-TZVP def2/J RIJCOSX strongSCF noautostart miniprint nopop
%maxcore  3500
%pal nprocs   64 end
* xyz   0   1
[geometry]
*
" > template.inp
for file in *.fchk *.log *.out; do
if [ -e "$file" ]; then
echo Converting ${file} to ${file%.*}.inp ... 
Multiwfn ${file} << EOF > /dev/null
oi
${file%.*}_sp.inp
-100
template.inp
q
EOF
fi
done