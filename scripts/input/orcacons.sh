#!/usr/bin/env bash
# 根据 1-based 原子编号/区间生成 ORCA %geom Constraints 片段。
# I/O: 参数如 2,7-8,10 -> 标准输出
# Requires: bash
# Note: 输出中自动换算为 ORCA 使用的 0-based 索引。

# 检查是否提供了参数
if [ -z "$1" ]; then
  echo "Usage: $0 \"2,7-8,10,21-28\""
  exit 1
fi

input=$1
output="%geom
  Constraints"

# 将逗号分隔的每一部分进行处理
IFS=',' read -ra ADDR <<< "$input"
for i in "${ADDR[@]}"; do
    if [[ "$i" == *"-"* ]]; then
        start=$(echo $i | cut -d'-' -f1)
        end=$(echo $i | cut -d'-' -f2)
        output+="\n  { C    $((start-1)):$((end-1)) C }"
    else
        output+="\n  { C    $((i-1)) C }"
    fi
done

output+="\n  end\nend"

echo -e "$output"