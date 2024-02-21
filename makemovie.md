# VMDを使ったmp4ファイルの作り方

[出力例.mp4](https://youtu.be/fxn1mU1ZZFQ)


## 必要なツール

- VMD 
- ffmpeg 
  -  homebrew を導入済みなら, コマンドプロンプトに以下を入力します. 
      ```bash
      brew install ffmpeg 
      ```


## 手順


### VMDでファイルを出力する

1. `hoge.lammpstrj` ファイルをVMDで出力します.


### VMD Movie Makerを使用して連番画像を生成する

1. 出力が完了したら, VMD Mainで `Extensions -> Visualization -> Movie maker` を選択します.
2. 表示された `VMD Movie Generator` で以下の設定を行います:
    - **Renderer**: Snap Shot を選択します.
    - **Movie Settings**: Trajectory を選択し, `4: Delete image files` のチェックを外します.
    - **Format**: MPEG-1 を選択します.
    - **Set working directory**: Tフォルダにデフォルトが設定されていますが, 作業しやすい場所に変更します.
    - **Name of movie**: ここでは仮に `untitled` のままとして説明します.
3. `Make Movie` をクリックします.
4. `Could not locate ppmtompeg Description: Would you like to specify its path?` に `No` と答える.


### 画像から動画を生成する

1. 画像出力が終了したら, 出力された画像ファイルのディレクトリをカレントディレクトリにしたコマンドプロンプトを準備します.
2. 以下のコマンドを入力します.(`%05d`は5桁の連番の場合です.3桁の場合は `%03d` に置き換えてください.)
    ```bash
    ffmpeg -r 30 -i untitled.%05d.ppm -vcodec libx264 -pix_fmt yuv420p -r 30 output.mp4
    ```
3. 動画出力が終了したら, 大量の残っている画像ファイルを次のコマンドで削除します.
    ```bash
    rm *.ppm
    ```


### .ppmを.jpgに変換する

もし `.ppm` を `.png` に変換したい場合は, 次のコマンドを実行します.
```bash
ffmpeg -i output.ppm output.png
```


### 半自動化プログラム

[makemovie.jl](/Share/rin/julia/makemovie.jl)
