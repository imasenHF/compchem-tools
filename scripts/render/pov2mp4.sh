#!/usr/bin/env bash
# 批量渲染 POV-Ray 文件为 PNG，并编码为 MP4。
# I/O: *.pov -> *.png + video.mp4
# Requires: POV-Ray, ffmpeg
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
povray +W678 +H472 +A ${inf} >/dev/null 2>&1
done
rm -f Arial.ttf
echo pov2png done!!!
rm -f video.mp4
ffmpeg -threads 6 -r 15 -i FRAME%04d.png -crf 22 video.mp4 >/dev/null >/dev/null 2>&1
echo png2mp4 done!!!