#!/usr/bin/env bash
# 使用 VMD/Tachyon 生成的 DAT 场景批量渲染 MO/ESP 图像。
# I/O: *.dat -> *.bmp
# Requires: tachyon_WIN64.exe
# Note: 支持 MO、ESP、MO_low 模式及可选分辨率。

if [ -n "$2" ]; then
    WIDTH=$2
else
    WIDTH=3840
fi

if [ -n "$3" ]; then
    HEIGHT=$3
else
    HEIGHT=2160
fi

rm -f Read.txt
ini=$(date +%s)
ncal=0
nfile=`ls *.dat|wc -l`
for inf in *.dat
do
start_time=$(date +%s)
if [ -n "$1" ] && [ "$1" == "MO" ]; then
# for molecular obital
  tachyon_WIN64.exe ${inf} -format BMP -o ${inf//.dat/_full.bmp} -trans_raster3d -res ${WIDTH} ${HEIGHT} -fullshade -numthreads 6 -aasamples 24
elif  [ -n "$1" ] && [ "$1" == "ESP" ]; then
# for esp
  tachyon_WIN64.exe ${inf} -format BMP -o ${inf//dat/bmp} -trans_vmd -res ${WIDTH} ${HEIGHT} -numthreads 6 -aasamples 24 -mediumshade
elif  [ -n "$1" ] && [ "$1" == "MO_low" ]; then
# for molecular obital (low shadow)
  tachyon_WIN64.exe ${inf} -format BMP -o ${inf//.dat/_noshadow.bmp} -trans_raster3d -res ${WIDTH} ${HEIGHT} -numthreads 6 -aasamples 24 -mediumshade
else
  tachyon_WIN64.exe ${inf} -format BMP -o ${inf//.dat/_full.bmp} -trans_raster3d -res ${WIDTH} ${HEIGHT} -fullshade -numthreads 6 -aasamples 24
fi
((ncal++))
echo "======== Job ($ncal of $nfile): Render ${inf//.dat} ========" |tee -a Read.txt
end_time=$(date +%s)
cost_time=$(($end_time-$start_time))
echo "Cost time is $(($cost_time/3600))h $(($cost_time/60))min $(($cost_time%60))s
" |tee -a Read.txt
done

ono=$(date +%s)
cost_time=$(($ono-$ini))
echo "---------------------------------
=== Job TERMINATED !!! ===
---------------------------------
Total job time is $(($cost_time/3600))h $(($cost_time/60-$cost_time/3600*60))min $(($cost_time%60))s" |tee -a Read.txt