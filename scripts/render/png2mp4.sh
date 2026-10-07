#!/usr/bin/env bash
# 将 FRAME%04d.png 图像序列编码为 MP4。
# I/O: FRAME*.png -> video.mp4
# Requires: ffmpeg
# Note: 默认 15 fps、CRF 22；会覆盖 video.mp4。

rm -f video.mp4
ffmpeg -threads 6 -r 15 -i FRAME%04d.png -crf 22 video.mp4 >/dev/null >/dev/null 2>&1
echo png2mp4 done!!!