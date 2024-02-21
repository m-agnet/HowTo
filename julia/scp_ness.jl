using Dates
td = Dates.format(today(), "yymmdd")
mkpath("./$(td)outputdir")
file_extensions = ["log", "yaml", "lammpstrj"] # 出力ファイルの拡張子
for file_ext in file_extensions
    run(`scp -r r.yamamoto@ness1:/home/r.yamamoto/Research/outputdir/$(file_ext)dir /Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir_ness/$(td)outputdir/`)
end
