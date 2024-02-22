
# はじめてのVisual Studio Code

URL: [https://github.com/m-agnet/HowTo.git](https://github.com/m-agnet/HowTo.git)

## インストール方法 

[VSCode公式サイト](https://code.visualstudio.com)


## 初期設定

### VSCodeの日本語化

初期設定は英語のため, 日本語にするために以下の設定を行う

- Extensionをクリック(⇧⌘X)し, 「Japanese」と入力
![スクリーンショット 2023-04-09 午前11.48.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2674841/88e83c82-87c7-b852-48b2-ea3cfd25ac46.png)

- 一番上の「Japanese Language Pack for Visual Studio Code」を選択し, 「Install」をクリック
⚠️画像ではインストール済みのため, 「アンインストール」と表示されている
![スクリーンショット 2023-04-09 午前11.52.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2674841/1fb8c4c2-539a-a3bc-ec15-9290a936f36b.png)

- 右下に現れる「Restart Now」をクリック

- VS Codeが再起動され, 日本語化される

同じ要領で, 様々な便利な拡張機能を入れることができる.

私が入れている拡張機能の中で, 脳死で入れても良いくらいオススメなものを以下に挙げる.

- Japanese Language Pack for Visual Studio Code
- Julia
- Lammps Syntax Highlighting
- LaTeX Workshop
- Markdown ALL in One
- Markdown PDF
- Material Icon Theme
- Remote - SSH

### ターミナルからVSCodeを開く

以下の作業を行うと, ターミナルからVSCodeを簡単に開くことができる

- コマンドパレット（⇧⌘P）を起動し, `shell`と入力
![スクリーンショット 2023-04-09 午後4.00.31.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/2674841/aa1f6c0a-fb32-3260-8117-4130abceb44e.png)

- 「シェルコマンド: PATH内に 'code' コマンドをインストールします」を選択

- 動作確認するため, 一旦VSCodeを閉じる
- 任意のディレクトリのターミナルから起動してみる 
  
```zsh:ターミナル　
code .
```

## 参考

[Visual Studio Code（VSCode）の設定をしてみた](https://qiita.com/TS1engineer/items/1b54f65ee87cb49582f5)

[homebrew-caskとは](https://qiita.com/swallowtail62/items/61244ea3c7d00f692823)