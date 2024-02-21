# makemovieディレクトリで実行する.
# 必要に応じてコメントアウトを解除してください.


# 画像群を用いて動画を作成
run(`ffmpeg -r 15 -i untitled.%05d.ppm -vcodec libx264 -pix_fmt yuv420p -r 30 output.mp4`)

# 1000番目の.ppmを.pngに変換
# run(`ffmpeg -i untitled.01000.ppm output.png`)

# 変換した.pngを適当なディレクトリに保存
# run(`mv output.png /Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir/imagedir/`)

# 動画を適当なディレクトリに保存
# run(`mv output.mp4 /Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir/moviedir/`)

# 残った大量の画像群を一気に削除
# run(`rm untitled.*.ppm`)