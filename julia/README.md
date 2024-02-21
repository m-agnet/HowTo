# julia

## カレントディレクトリの簡単な説明.

- [lammps_exe.jl](lammps_exe.jl)
  - lammpsファイルの実行と出力ファイルの保管をする.
  - lammpsファイル実行時に出力される*.logファイル,*.yamlファイルが指定した同一フォルダに,それぞれのフォルダを作成して保管される.
    - 保管される出力ファイル名の頭には実験日時が追記される.
  - lammpsファイルと同一ディレクトリにある*.lammpstrjファイルは削除される.
- [lammps_modexe.jl](lammps_modexe.jl)
  - [lammps_exe.jl](lammps_exe.jl)にパラメータ編集機能を追加したもの.
  - lammpsファイルを適切にパラメータ処理する必要がある.
  - 設定したパラメータごとにlammpsファイルを編集して繰り返し実行させることができる.
    - 保管される出力ファイル名の頭にはそれぞれ設定したパラメータと実験日時が追記される.
- [makemovie.jl](./makemovie.jl)
  - 使い方は[makemovie.md](../HowTo/makemovie.md)に記述.