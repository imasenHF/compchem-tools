#!/usr/bin/env bash
# 批量使用 POV-Ray 渲染当前目录的 POV 文件。
# I/O: *.pov -> *.png
# Requires: POV-Ray
# Note: 文本渲染可能需要脚本目录中的字体文件；字体不随项目分发。

for file in *_TXT.pov; do
    if [[ -e "$file" ]]; then
        pov_file="${file/_TXT.pov/.pov}"
        if [[ -e "$pov_file" ]]; then
            grep '^text{' "$file" >> "$pov_file"
			rm -f $file
        fi
    fi
done

# echo -ne '\n' | CYL_mergeTXT
# echo mergeTXT done!!!

cp $(dirname $(readlink -f "$0"))/Arial.ttf ./
for inf in *.pov
do
echo Processing ${inf} ...
povray +W1290 +H1314 +A ${inf} >/dev/null 2>&1
done
rm -f Arial.ttf
echo pov2png done!!!