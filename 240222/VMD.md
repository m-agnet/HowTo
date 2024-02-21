
# VMD 

## インストール方法

[公式サイトのダウンロードページ](https://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD)からダウンロードの手続きを行う.

ログインページが出るが, 適当なものを入力する. あとで思い出しやすいものにするなら, 今後研究室で使う可能性のあるユーザ名とパスワードがあるのでそれにしておくと良い.


## 操作方法

- VMDアプリを起動し, `File` -> `New Molecule ...`とクリック.
- `Load files for`が`New Molecule`になっていることを確認する.
- `Browse...`をクリックし表示したいファイルを選ぶ.
- `Load`をクリック
  
## グラフィック操作

- VMD Mainディスプレイの`Graphics` -> `Representations...`
- `Drawing Method`を選択し, `Points`に変更.
- `Thickness`を適当に大きくする. 

## 参考

[YouTube: 10.2 How to install VMD on a newer Mac](https://www.youtube.com/watch?v=kFx05MrNOVc)
[VMDの使い方の基本 (Mac)](https://oosakik.hatenablog.com/entry/2019/11/10/VMDの使い方_を初心者にもわかりやすく_%28Mac%29)

# VMD起動時の設定を変更する

分子可視化ソフトであるVMDの起動時の設定を変更する方法について解説する. 

何回も起動することになるソフトなので, 初期設定をこのように変えるのはオススメである.

## .vmdrcの置き場

- ./.vmdrc
  - 現在のディレクトリに`.vmdrc`を置いておく
- ~/.vmdrc
  - 自分のホームディレクトリに`.vmdrc`を置いておく 
- /VMDDIR/.vmdrc 
  - VMDのインストールディレクトリに`.vmdrc`を置いておく

の３つのやり方がある. ３つのディレクトリは上に行くほど優先順位が高くなる.

最も手っ取り早いのは、自分のホームディレクトリに`.vmdrc`を置いておくことである.

## .vmdrcの中身

例えば、以下のようにする

```tcl
#main,graphics画面を表示
menu main on
menu graphics on
#軸の表示を消す
axes location Off
#背景を白にする
color Display Background white
```

これにより, 軸表示がなくなり、白い背景で起動するようになる.

## 参考

[VMD起動時の設定を変更する](https://qiita.com/tacoma/items/c2466b2660f38c438ea7)



