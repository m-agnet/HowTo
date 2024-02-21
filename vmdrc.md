# VMD起動時の設定を変更する


分子可視化ソフトであるVMDの起動時の設定を変更する方法について解説する.


## .vmdrcをおく
* ./.vmdrc（つまり現在のディレクトリに`.vmdrc`を置いておく）
* ~/.vmdrc（自分のホームディレクトリに`.vmdrc`を置いておく） 
* /VMDDIR/.vmdrc (VMDのインストールディレクトリに`.vmdrc`を置いておく)

の３つのやり方がある。
ちなみに３つのディレクトリは上に行くほど優先順位が高くなる。

最も手っ取り早いのは、自分のホームディレクトリに`.vmdrc`を置いておくことである。

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

これにより、軸も表示されず、白い背景で起動する

