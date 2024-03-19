
# Macコマンド一覧

URL: [https://github.com/m-agnet/HowTo.git](https://github.com/m-agnet/HowTo.git)

## ディレクトリとは

- ディレクトリ : フォルダのこと.
- カレントディレクトリ : 現在いるディレクトリのこと.
- ホームディレクトリ : ターミナルを起動したときのデフォルトのディレクトリのこと.

## チートシート

- ls : カレントディレクトにあるファイルを表示する.
- cd : カレントディレクトリにあるファイルに移動する.
- touch : 中身が空のファイルを作る.
- mkdir : 新しい空のディレクトリを作る.
- mv : ファイルを移動したり, ファイル名を変更したりする.
- cp : ファイルをコピーする.
- rm : ファイルを削除する.
- open : ターミナルからFinderでファイルを開く.

## ls コマンド

カレントディレクトにあるファイルを表示する.（listの略）

```bash
ls  # カレントディレクトリにあるファイルやディレクトリを表示する
ls -a  # 隠しファイルも含めファイルやディレクトリを全て表示する
```

隠しファイルとは通常では表示されないようになっているファイルやディレクトリのことです.

重要なファイルをユーザーが勝手にいじってしまわないように, 通常では表示されないようになっています.

隠しファイルは名前の前に「.（ドット）」がついているファイルやディレクトリになります.

## cd コマンド

カレントディレクトリにあるファイルに移動する.（change directoryの略）

```bash
cd test.html  # testテストというファイルに移動する
cd ~/  # ホームディレクトリに移動する
cd ..  # 一つ上の階層のファイルに移動する
```

## touch コマンド

中身が空のファイルを作る.

```bash
touch test.html  # test.htmlという中身が空のファイルを作る
```

## mkdir コマンド

新しい空のディレクトリを作る.（make directoryの略）

```bash
mkdir testdir # testdirというディレクトリを作る
```

## mv コマンド

ファイルを移動したり, ファイル名を変更したりする.（moveの略）

```bash
mv test.html tmp/  # test.htmlというファイルを相対パスでtmp/に移動する
mv test.html test2.html  # test.htmlというファイルをtest2.htmlに名前変更する
```

## cp コマンド

ファイルをコピーする.（copyの略）

```bash
cp test.html tmp/  # test.htmlを相対パスでtmp/というディレクトリの中にコピーする
cp test.html test2.html  # test.htmlをtest2.htmlという名前でコピーする
cp −r dir /tmp/  # dirというディレクトリとその中身を絶対パスで/tmp/にそっくりコピーする
```

## rm コマンド

ファイルを削除する.（removeの略）

```bash
rm test.html  # test.htmlを削除する
rm *.ppm  # 拡張子.ppmのファイルをすべて削除する
rm -r test  # testというディレクトリとその中身を削除する
```

rmコマンドは取り返しのつかないファイルの削除になります.

気をつけて扱ってください.

このコマンドの被害者は思っているより多いです.


## openコマンド

ターミナルからFinderでファイルを開く.

```bash
open .  # 現在のターミナルのディレクトリFinderで開く
open ~/  # ホームディレトリをFinderで開く
```

## 参考にした記事

[Macのターミナルコマンド一覧（基本編）](https://qiita.com/ryouzi/items/f9dee1540a04a0bfb9a3)