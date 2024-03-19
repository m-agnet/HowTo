
# はじめてのLAMMPS

URL: [https://github.com/m-agnet/HowTo.git](https://github.com/m-agnet/HowTo.git)

## インストール方法

CUIのソフトを簡単に管理できるというHomebrewを用いる. 

[Homebrewのインストール](https://brew.sh)自体はネットで調べると実行に時間がかかるが簡単にできる.

どこでも良いのでターミナルに以下を実行.

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

その上でどこでも良いのでターミナルに以下を実行.

```zsh
brew install lammps
```

`/opt/homebrew/share/lammps/examples/` にLAMMPSのサンプルが入っていれば成功.

## 実行してみよう

とりあえず実行をするには, 以下のコマンドをLAMMPSファイルのディレクトリ上で走らせる.

※LAMMPSファイルには「in.」 が接頭についている.

```zsh
mpirun -n 4 lmp_mpi -log output.log -in in.input
```

私はLAMMPSの実行によって, 拡張子がそれぞれ, 「.log」「.lammpstrj」「.yaml」の3つのファイルを出力するようにしている. 

- .log : 実験ログの確保のために出力. 
  - これのタイトルと同一の出力ファイルがもともとどのような系の設定から生まれたものなのかを確認するためにマストで出力している. 
  - 計算時間も下の方に記載される.
- .lammpstrj : VMDで系の動きを確認するのに使用する. 
  - データサイズが大きくなるので注意が必要.
- .yaml : データ分析をする際, 各物理量を取得するのに重宝. 

## 例として使用するファイル

- [in.2dLJ](./LAMMPS/in.2dLJ)
  - 私が実際に使っているコードの基本形. 
- [in.logo](./LAMMPS/in.logo)
  - [LAMMPS公式サイト](https://www.lammps.org/#gsc.tab=0)にあるファイル(input script).
- [in.melt_mod](./LAMMPS/in.melt_mod)
  - サンプルmeltに入っているファイルを編集したもの.

## 快適にするために

私はjuliaを用いてある程度の自動化を行なっている. 具体的には以下のことをプログラムに任せている.

- いちいち打ち込む必要のあった`mpirun -n 4 -in in.input`を代わりに打ち込んでもらう.
- 出力されるファイルの接頭に実験時刻をつけて, ファイル名の一意性を守る.
- 出力されるファイルを拡張子ごとに分けて, outputdirというディレクトリに保存.

私のコードを参考にしたい方は[julia](../julia/)を参照すると良い.

また, 中川研究室では計算機クラスターを用いて, 計算の高速処理を達成している. これの使い方は[ness.md](../ness.md)を見るといい. これもjuliaで自動化することができる.

## 参考になるもの

- [LAMMPS Documentation](https://docs.lammps.org/Manual.html)
  - ある程度慣れてから, 何かわからないところがあれば, とりあえずドキュメントを見ると良い. -> それでもわからない可能性も大いにあるので, その時は遠慮せずに先輩に聞くこと.