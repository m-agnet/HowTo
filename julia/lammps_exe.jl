#=
lammpsファイルの実行及び出力ファイルの保管.
- lammpsファイル実行時に出力される*.logファイル,*.yamlファイルが指定した同一フォルダに,それぞれのフォルダを作成して保管される.
- lammpsファイルと同一ディレクトリにあるoutputファイルは削除.
- outputdirまでの絶対パスを任意に変更して使用してください.
=#

using Glob # *を使ってパターンマッチングするためのライブラリ.
using Dates # 日時を取得するためのライブラリ.

# lammpsfile=glob("in.*")[1] # 実行ファイルを指定.
lammpsfile="in.melt" # 実行ファイルを指定.
file_extensions = ["log", "yaml", "lammpstrj"] # 扱う出力ファイルの種類を指定.
outputpath = "/Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir" # outputdirまでの絶対パス.

n = string(now())   # 実験日時の記録
run(`mpirun -n 4 lmp_mpi -log output.log -in $(lammpsfile)`) # lammpsの実行.

# 出力ファイルの保管.
for file_ext in file_extensions

    # 読み込みに失敗したら次のループに進む.
    try
        readfile = glob("*.$(file_ext)")[1] # 読み込みファイルを指定.
        script = read(readfile, String) # 読み込みファイルを読み込む.
        writepath = joinpath(outputpath, "$(file_ext)dir", "$(n)$(readfile)") # 書き込みファイルの絶対パス.
        fp = open(writepath, "w") # 書き込みファイルを作成して開く.

        if file_ext == "log" 
            # logファイルのときに行う処理を記述.
            println(fp, "実験日時: $(n)") # 実験日時の書き込み.
        end

        write(fp, script) # 読み込んだテキストを書き込む.
        close(fp) # 書き込みファイルを閉じる.

        if file_ext == "yaml" 
            # yamlファイルのときに行う処理を記述.

        end

        if file_ext == "lammpstrj" 
            # lammpstrjファイルのときに行う処理を記述.

        end

        rm(readfile)

    catch
        
    end
end
