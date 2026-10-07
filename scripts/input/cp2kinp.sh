#!/usr/bin/env bash
# 通过 Multiwfn 批量从 GJF 生成 CP2K 输入文件。
# I/O: *.gjf -> *.inp
# Requires: Multiwfn
# Note: Multiwfn 菜单序列及 CP2K 参数写死在脚本中，使用前需核对。

icc=0
for inf in *.gjf #*.gjf *.cif *.inp *.gjf 
do
((icc++))
echo Converting ${inf} to ${inf%.*}.inp ... \($icc\)
Multiwfn ${inf} << EOF > /dev/null
{inf}
cp2k
${inf//gjf/inp}
-9
5
600,60
0
-7
XY
-4
4
-3
1
3
2
4
0
q
EOF
done

# << EOF > /dev/null
# {inf}
# cp2k
# ${inf%.*}.inp
# -9
# 1
# 0 #charge
# 2
# 1 #multiplicity
# 3
# 1,1,1 #supercell
# #4 #Toggle using finer grid for exchange-correlation part
# #5
# #400,55 #CUTOFF and REL_CUTOFF
# #8 #Toggle using DFT+U
# 10
# 1 #print level 0_Silent 1_Low 2_M 3_H
# 0
# -7
# XY #periodic NONE, X, XY, XYZ, XZ, Y, YZ, Z
# -4
# 0 #Atom charge print  0 None 1 Mulliken 2 Lowdin 3 Hirshfeld 4 Hirshfeld-I 5 Voronoi 6 RESP 7 REPEAT
# -3
# 0 #cube file output  0 None 1 Electron density 2 ELF 3 Exchange-correlation potential 4 Hartree potential (negative of ESP) 5 Each component of electric field 6 Molecular orbital(s)
# #-2 #Toggle exporting molden file
# -1
# 3 #task  1 Energy 2 E + force 3 cell fixed opt 4 struct cell opt 5 Vibration 6 MD 7 Searching transition state 8 BAND 9 NMR 10 Polarizability 11 BSSE 13 Rt propagation electron dynamics 14 PIMD 15 XAS
# 1
# 2 #Method  2 PBE -3 PBEsol 6 PBE0(-6ADMM) 7 B3LYP(-7ADMM) 10 M062X(-10ADMM) 30 GFN1-xTB
# 2
# 2 #basis set and pseudopotential  2 DZVP-MOLOPT-SR-GTH 3 TZVP-MOLOPT-GTH 10 6-31G* 11 6-311G**
# 3
# 0 #0 None 1 DFT-D3 2 DFT-D3(BJ) 5 rVV10
# #6 #Toggle smearing electron occupation
# 8
# 1,1,1 #k-points
# #9
# # #Set atom position constraint
# 0
# q
# EOF