#!/usr/bin/env bash
# 通过 Multiwfn 批量将 Gaussian formatted checkpoint 转换为 PDB。
# I/O: *.fchk -> *.pdb
# Requires: Multiwfn
# Note: 要求 Multiwfn 可从 PATH 调用。

for inf in *.fchk
do
echo Processing ${inf%fchk} ...
echo -e '100
2
1
'${inf%fchk}pdb'' | Multiwfn "${inf}" > /dev/null 2>&1
done