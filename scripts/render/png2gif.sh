#!/usr/bin/env bash
# 将 FRAME%04d.png 图像序列编码为 GIF。
# I/O: FRAME*.png -> video.gif
# Requires: ffmpeg
# Note: 默认 15 fps；会覆盖 video.gif。

rm -f palette.png
rm -f video.gif
ffmpeg -threads 6 -i FRAME0001.png -vf palettegen palette.png >/dev/null 2>&1
ffmpeg -threads 6 -r 15 -i FRAME%04d.png -i palette.png -lavfi paletteuse video.gif >/dev/null 2>&1
echo png2gif done!!!