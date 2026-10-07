#!/usr/bin/env bash
# 用 xtbopt.xyz 中的坐标替换指定 Gaussian GJF 中已有坐标块。
# I/O: xtbopt.xyz + H2O_org.gjf -> 原地修改
# Requires: grep, sed
# Note: 文件名固定且会改写 GJF；适合个人工作流示例。

# 输入文件路径
xtbopt_xyz="xtbopt.xyz"
h2o_gjf="H2O_org.gjf"

# 提取xtbopt.xyz中的分子坐标
coord_section1=$(grep -E '^[[:space:]]*[A-Za-z]+[[:space:]]+[-0-9.]+[[:space:]]+[-0-9.]+[[:space:]]+[-0-9.]+' "$xtbopt_xyz")
Coord1=$(echo "$coord_section1" | tr '\n' '\r')  # 将换行符转换为特定符号

# 提取H2O_org.gjf中的分子坐标
coord_section2=$(grep -E '^[[:space:]]*[A-Za-z]+[[:space:]]+[-0-9.]+[[:space:]]+[-0-9.]+[[:space:]]+[-0-9.]+' "$h2o_gjf")
Coord2=$(echo "$coord_section2" | tr '\n' '\r')  # 将换行符转换为特定符号

# 将H2O_org.gjf中的内容备份，将换行符转换为特定符号
cp "$h2o_gjf" "${h2o_gjf}_backup"
tr '\n' '\r' < "${h2o_gjf}_backup" > "$h2o_gjf"

# 替换分子坐标
sed -i "s|$Coord2|$Coord1|" "$h2o_gjf"

# 将特定符号恢复为换行符
sed -i "s|\r|\n|g" "$h2o_gjf"

echo "分子坐标已从$xtbopt_xyz提取，并替换到$H2O_org.gjf中"