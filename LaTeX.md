# はじめてのLaTeX

URL: [https://github.com/m-agnet/HowTo.git](https://github.com/m-agnet/HowTo.git)

## 対象読者

- TeX ってなに?な方.
- ゼミ資料を簡単に見やすく作りたい方.
- Wordで卒論を書こうとしてる方.
- TeXのコンパイルを自動化したい方.
- 私のusepackageを参考にしたい方.

## 目次

- 山本が使用している雛形
- よく使うコマンド
- VScodeでの執筆をより快適にするために

## 山本が使用している雛形.

以下の[雛形](./LaTeX/test/test.tex)をコピー&ペーストで任意のtexファイルに書き込む. (拡張子は「.tex」, ファイル名に日本語を使うとコンパイルがうまくいかないことがあるので注意.)

```latex
\documentclass[12pt, dvipdfmx]{jsreport}


% 枠
\usepackage{fancybox}
\usepackage{ascmac}
% 色
\usepackage{color}
% 数式
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{mathtools}
\usepackage{bm,physics}
\usepackage{siunitx}
\usepackage[thicklines]{cancel}
% 画像
\usepackage[dvipdfmx]{graphicx} % 画像出力をする.
% \usepackage[draft]{graphicx} % 画像出力を枠だけにする.
\usepackage[hang,small,bf]{caption}
\usepackage[subrefformat=parens]{subcaption}
\usepackage{wrapfig} % 文字の回り込み用のパッケージ.
\usepackage{here}
% グラフ
\usepackage{tikz}
\usetikzlibrary{
  intersections,
  calc,
  arrows.meta
}
% ソースコード
\usepackage{listings,jlisting}
\lstset{
    language=C++,
    stringstyle={\ttfamily},
    commentstyle={\ttfamily},
    basicstyle={\ttfamily},
    columns=fixed,
    frame={tb},
    breaklines=true,
    breakindent = 10pt,
    columns=[l]{fullflexible},
    backgroundcolor=\color[gray]{.90}, % pdfをコピペしたときに行番号を巻き込まないようにする.
    numbers=left, % 行数を表示したければonにする.
    xrightmargin=0em,
    xleftmargin=3em,
    numberstyle={\scriptsize},
    stepnumber=1,
    numbersep=1em,
    tabsize=2,
    lineskip=-0.5ex
}
% アンカー
\usepackage[dvipdfmx]{hyperref}
\usepackage{pxjahyper}
\hypersetup{
    setpagesize=false,
    bookmarksnumbered=true,
    bookmarksopen=true,
    colorlinks=true,
    linkcolor=blue,
    citecolor=red,
    urlcolor=magenta
}
% 数式相互参照
\usepackage{cleveref}
\usepackage{autonum}
\numberwithin{equation}{subsection}

\begin{document}

\title{}
\author{}
\date{\today}
\maketitle
% 目次
\setcounter{tocdepth}{3}
\tableofcontents
\newpage
% 本文





\end{document}
```

## よく使うコマンドの使用例

### \section系

```latex
\chapter{第1章}
\section{1.1}
\subsection{1.1.1}
```

### \align

```latex
\begin{align}
  \label{Maxwell's equations}
  \div{\bm{B(t,\bm{x})}} &= 0 \\
  \curl{\bm{E}(t,\bm{x})} &= - \pdv{\bm{B}(t,x)}{t} \\
  \div{\bm{D}(t,\bm{x})} &= \rho(t,\bm{x}) \\
  \curl{\bm{H}(t,\bm{x})} &= \bm{j}(t,\bm{x}) + \pdv{\bm{D}(t,\bm{x})}{t}
\end{align}
```

### \figure

```latex
\begin{figure}[H]
  \centering
  \includegraphics[scale=0.5]{hoge1.png}
  \label{fig: hoge1}
\end{figure}
```

## 以上のusepackage群の思想

- 数式全てに番号を振ることはせずに, 相互参照をする数式にだけ自動で番号が割り振られるようにしている. 
  - そのため, `\algin`と`\align*`を使い分けるといったことがない.
  - また, 資料が肥大化した時に簡潔で見やすいものになる.
- `\usepackage{pysics}`を用いて楽に執筆することを推奨している.
  - 誰かと共同編集するのであれば, その限りではない.


## VScodeでの執筆をより快適にするために

### .latexmkrcの設定

ホームディレクトリの隠しファイル「[.latexmkrc](./LaTeX/.latexmkrc)」に以下を書き込む. 

ターミナルで以下のコマンドを実行.

```bash
cd ~
ls -a
```

上記のコマンドを実行して「.latexmkrc」がなければ新規作成する.

```perl
#!/usr/bin/env perl
 
# LaTeX
$latex = 'platex -synctex=1 -halt-on-error -file-line-error %O %S';
$max_repeat = 5;
 
# BibTeX
$bibtex = 'pbibtex %O %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %S';
 
# index
$makeindex = 'mendex %O -o %D %S';
 
# DVI / PDF
$dvipdf = 'dvipdfmx %O -o %D %S';
$pdf_mode = 3;
 
# preview
$pvc_view_file_via_temporary = 0;
if ($^O eq 'linux') {
    $dvi_previewer = "xdg-open %S";
    $pdf_previewer = "xdg-open %S";
} elsif ($^O eq 'darwin') {
    $dvi_previewer = "open %S";
    $pdf_previewer = "open %S";
} else {
    $dvi_previewer = "start %S";
    $pdf_previewer = "start %S";
}
```

### settings.json ビルドの設定

「管理->設定->JSONを開く(右上にあるアイコン)」で以下の「[settings.json](./LaTeX/settings.json)」コードをコピー&ペーストする.

以降, texファイルの保存のたびに自動でpdfがビルドされ, プレビューを確認することができるようになる.

- 「⌥⌘B」ビルドコマンド
- 「⌥⌘V」プレビューコマンド

```json
{
    // ---------- Language ----------

    "[tex]": {
        // スニペット補完中にも補完を使えるようにする
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        // インデント幅を2にする
        "editor.tabSize": 2
    },

    "[latex]": {
        // スニペット補完中にも補完を使えるようにする
        "editor.suggest.snippetsPreventQuickSuggestions": false,
        // インデント幅を2にする
        "editor.tabSize": 2
    },

    "[bibtex]": {
        // インデント幅を2にする
        "editor.tabSize": 2
    },


    // ---------- LaTeX Workshop ----------

    // 使用パッケージのコマンドや環境の補完を有効にする
    "latex-workshop.intellisense.package.enabled": true,

    // 生成ファイルを削除するときに対象とするファイル
    // デフォルト値に "*.synctex.gz" を追加
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.bbl",
        "*.blg",
        "*.idx",
        "*.ind",
        "*.lof",
        "*.lot",
        "*.out",
        "*.toc",
        "*.acn",
        "*.acr",
        "*.alg",
        "*.glg",
        "*.glo",
        "*.gls",
        "*.ist",
        "*.fls",
        "*.log",
        "*.fdb_latexmk",
        "*.snm",
        "*.nav",
        "*.dvi",
        "*.synctex.gz"
    ],

    // 生成ファイルを "out" ディレクトリに吐き出す
    "latex-workshop.latex.outDir": "out",

    // ビルドのレシピ
    "latex-workshop.latex.recipes": [
        {
            "name": "latexmk",
            "tools": [
                "latexmk"
            ]
        }
    ],

    // ビルドのレシピに使われるパーツ
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk",
            "command": "latexmk",
            "args": [
                "-silent",
                "-outdir=%OUTDIR%",
                "%DOC%"
            ]
        }
    ]
}
```

### latex.json ユーザースニペットの設定

VScodeの左下にある「管理->ユーザスニペット」からlatex.jsonを選択. 下記のjsonコードをコピー&ペーストする.

以降, 新規texファイルで「report」と打ち込むとすぐにtexでpdfを作成することができるようになる.

```json
{
    "report": {
        "prefix": "report",
        "body": [
            "\\documentclass[${1:12pt, divpdfmx}]{${2:jsreport}}",
            "",
            "",
            "% 枠",
            "\\usepackage{fancybox}",
            "\\usepackage{ascmac}",
            "% 色",
            "\\usepackage{color}",
            "% 数式",
            "\\usepackage{amsmath}",
            "\\usepackage{amsfonts}",
            "\\usepackage{mathtools}",
            "\\usepackage{bm,physics}",
            "\\usepackage{siunitx}",
            "\\usepackage[thicklines]{cancel}",
            "% 画像",
            "\\usepackage[dvipdfmx]{graphicx} ",
            "% \\usepackage[draft]{graphicx} % 画像出力を枠だけにする.",
            "\\usepackage[hang,small,bf]{caption}",
            "\\usepackage[subrefformat=parens]{subcaption}",
            "\\usepackage{here}",
            "% ソースコード",
            "\\usepackage{listings,jlisting}",
            "\\lstset{",
            "language=C++,",
                "stringstyle={\\ttfamily},",
                "commentstyle={\\ttfamily},",
                "basicstyle={\\ttfamily},",
                "columns=fixed,",
                "frame={tb},",
                "breaklines=true,",
                "columns=[l]{fullflexible},",
                "backgroundcolor=\\color[gray]{.90}, % pdfをコピペしたときに行番号を巻き込まないようにする.",
                "numbers=left, % 行数を表示したければonにする.",
                "xrightmargin=0em,",
                "xleftmargin=3em,",
                "numberstyle={\\scriptsize},",
                "stepnumber=1,",
                "numbersep=1em,",
                "tabsize=2,",
                "lineskip=-0.5ex",
            "}",
            "% アンカー",
            "\\usepackage[dvipdfmx]{hyperref}",
            "\\usepackage{pxjahyper}",
            "\\hypersetup{",
                "setpagesize=false,",
                "bookmarksnumbered=true,",
                "bookmarksopen=true,",
                "colorlinks=true,",
                "linkcolor=blue,",
                "citecolor=red,",
                "urlcolor=magenta",
            "}",
            "% 数式相互参照",
            "\\usepackage{cleveref}",
            "\\usepackage{autonum}",
            "\\numberwithin{equation}{subsection}",
            "\\begin{document}",
            "",
            "\\title{${4}}",
            "\\author{${5}}",
            "\\date{${6:\\today}}",
            "\\maketitle",
            "% 目次",
            "\\setcounter{tocdepth}{3}",
            "\\tableofcontents",
            "\\newpage",
            "% 本文",
            "",
            "",
            "$0",
            "",
            "",
            "\\end{document}"
        ],
        "description": "レポート用テンプレート"
    }
}
```

## 参考になる記事

[pysics パッケージの使い方(オススメ!!)](http://mirrors.ibiblio.org/CTAN/macros/latex/contrib/physics/physics.pdf)

[latex-の数式環境って種類が多い](https://qiita.com/Yarakashi_Kikohshi/items/ef693d7abb195c55af7a#latex-の数式環境って種類が多い "https://qiita.com/Yarakashi_Kikohshi/items/ef693d7abb195c55af7a#latex-の数式環境って種類が多い")

[LaTeX で物理学徒が最低限知っておくべきこと・私が気を付けていること](https://qiita.com/yetput_ikura/items/912cc9d9496ebefcccd9 "https://qiita.com/yetput_ikura/items/912cc9d9496ebefcccd9")

## リンク

[はじめてのLaTeX](https://qiita.com/m-agnet/items/664ea5532db5db4144fe)

## 

長い資料となったけど最後まで読んでくれてありがとう! 

快適にLaTeXを用いて, 良い研究室ライフを!!