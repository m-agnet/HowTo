# makemovieディレクトリで実行する.
run(`ffmpeg -r 15 -i untitled.%05d.ppm -vcodec libx264 -pix_fmt yuv420p -r 30 output.mp4`)
run(`ffmpeg -i untitled.01000.ppm output.png`)
run(`mv output.png /Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir/imagedir/`)
run(`mv output.mp4 /Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir/moviedir/`)