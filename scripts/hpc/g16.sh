#!/usr/bin/env bash
# 批量运行当前目录的 Gaussian 16 GJF，并对 checkpoint 执行 formchk。
# I/O: *.gjf -> *.out, *.fchk
# Requires: Gaussian 16, formchk
# Note: 直接遍历当前目录所有 GJF。

for file in *.gjf; do
g16 < $file |tee ${file//gjf/out}
formchk ${file//gjf/chk}
done