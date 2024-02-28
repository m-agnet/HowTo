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

### jlisting.sty ソースコードを記載する時の設定

例えば以下の場所に保存する.

```
/usr/local/texlive/2023/texmf-dist/tex/latex/listing/listing.sty
```

```zsh
\NeedsTeXFormat{LaTeX2e}
\def\filedate{2006/02/20}
\def\fileversion{0.2}
\ProvidesPackage{jlisting}[\filedate\space\fileversion\space(Thor)]
%
\newcount\lst@nextchar
\let\lst@@ProcessSpace\lst@ProcessSpace
\def\lst@ProcessSpace#1{%
   \lst@check@chartype{#1}%
      \lst@@ProcessSpace
      \lst@whitespacetrue}
\let\lst@@ProcessLetter\lst@ProcessLetter
\def\lst@ProcessLetter#1#2{%
   \lst@check@chartype{#2}%
      {\lst@@ProcessLetter{#1}}%
      \relax}
\let\lst@@ProcessDigit\lst@ProcessDigit
\def\lst@ProcessDigit#1#2{%
   \lst@check@chartype{#2}%
      {\lst@@ProcessDigit{#1}}%
      \relax}
\let\lst@@ProcessOther\lst@ProcessOther
\def\lst@ProcessOther#1#2{%
   \lst@check@chartype{#2}%
      {\lst@@ProcessOther{#1}}%
      \relax}
\let\lst@@ProcessTabulator\lst@ProcessTabulator
\def\lst@ProcessTabulator#1{%
   \lst@check@chartype{#1}%
      \lst@@ProcessTabulator
      \relax}
\def\lst@check@chartype#1#2#3{%
   \edef\@tempa{\lst@nextchar=`\string#1\relax}%
   \afterassignment\remove@to@nnil
   \@tempa\@nnil
   #2%
   \ifnum\lst@nextchar<\@cclvi
      #3%
   \else
      \lst@ifletter \else \lst@OutputOther \fi
      \lst@whitespacefalse
      \expandafter\lst@AppendJchar
   \fi
   #1}
\def\lst@AppendJchar#1#2{%
   \lst@check@chartype{#2}%
      {\advance\lst@length\@ne\lst@Append{#1}}%
      \relax}
\def\lst@check@chartype@BOL#1{%
   \edef\@tempa{\lst@nextchar=`\string#1\relax}%
   \afterassignment\remove@to@nnil
   \@tempa\@nnil
   \ifnum\lst@nextchar<\@cclvi\else
      \lst@whitespacefalse
      \expandafter\lst@AppendJchar
   \fi
   #1}
\def\lst@InputListing#1{%
   \begingroup
      \lsthk@PreSet \gdef\lst@intname{#1}%
      \expandafter\lstset\expandafter{\lst@set}%
      \lsthk@DisplayStyle
      \catcode\active=\active
      \lst@Init\relax \let\lst@gobble\z@
      \lst@SkipToFirst
      \lst@ifprint \def\lst@next{\lst@get@filecontents{#1}}%
      \else        \let\lst@next\@empty
      \fi
      \lst@next
      \lst@DeInit
   \endgroup}
\newread\lst@inputfile
\def\lst@get@filecontents#1{%
   \let\lst@filecontents\@empty
   \openin\lst@inputfile=#1\relax
   \let\@lst@get@filecontents@prevline\relax
   \lst@get@filecontents@loop
   \closein\lst@inputfile
   \lst@filecontents\empty}
\def\lst@get@filecontents@loop{%
   \read\lst@inputfile to\@lst@get@filecontents@currline
   \ifx\@lst@get@filecontents@prevline\relax\else
      \expandafter\expandafter\expandafter\def
      \expandafter\expandafter\expandafter\lst@filecontents
      \expandafter\expandafter\expandafter{%
         \expandafter\lst@filecontents\@lst@get@filecontents@prevline}%
   \fi
   \let\@lst@get@filecontents@prevline\@lst@get@filecontents@currline
   \ifeof\lst@inputfile\else
      \expandafter\lst@get@filecontents@loop
   \fi}
%%% [$B$3$N=hM}$b!$AjEv6/0z$G$9!%(B]
\def\lst@BOLGobble{%
   \ifnum\lst@gobble>\z@
      \@tempcnta\lst@gobble\relax
      \expandafter\lst@BOLGobble@
   \else
      \expandafter\lst@check@chartype@BOL
   \fi}
\def\lst@BOLGobble@#1{%
   \let\lst@next#1%
   \ifx \lst@next\relax\else
   \ifx \lst@next\lst@MProcessListing\else
   \ifx \lst@next\lst@ProcessFormFeed\else
   \ifx \lst@next\lstenv@backslash
      \let\lst@next\lstenv@BOLGobble@@
   \else
      \let\lst@next\lst@BOLGobble@@
      \ifx #1\lst@ProcessTabulator
         \advance\@tempcnta-\lst@tabsize\relax
         \ifnum\@tempcnta<\z@
            \lst@length-\@tempcnta \lst@PreGotoTabStop
         \fi
      \else
         \edef\@tempa{\lst@nextchar=`\string#1\relax}%
         \@tempa
         \ifnum\lst@nextchar<\@cclvi\else
            \advance\@tempcnta\m@ne
         \fi
         \advance\@tempcnta\m@ne
      \fi
   \fi \fi \fi \fi
   \lst@next}
\def\lst@BOLGobble@@{%
   \ifnum\@tempcnta>\z@
      \expandafter\lst@BOLGobble@
   \else
      \expandafter\lst@check@chartype@BOL
   \fi
}
%
%    \begin{$B=$@5;v9`(B}{1.3}
% $B$A$g$C$H$7$?=$@5(B
\gdef\lst@breakProcessOther#1{\lst@ProcessOther#1}
% $B%=!<%9%3!<%IL\<!$K$*$1$kJ8;z$HHV9f$N6u$-(B
\let \l@lstlisting = \l@figure
% $B%-%c%W%7%g%s$H%=!<%9%3!<%IL\<!$KBP$9$kF|K\8lBP1~(B
\def\lstlistingname{$B%=!<%9%3!<%I(B}
\def\lstlistlistingname{$B%=!<%9%3!<%IL\<!(B}
%    \end{$B=$@5;v9`(B}
\endinput
% 
%#!platex
\documentclass[papersize]{jsarticle}
% Macros
\IfFileExists{dvipdfmx.def}{%
  \usepackage[dvipdfmx]{color,graphicx}%
}{%
  \usepackage[dvipdfm]{color,graphicx}%
}
\usepackage{listings}[2004/09/07]
\usepackage{jlisting}[2006/02/20]
\usepackage{url} 
\usepackage{verbatim}

\makeatletter
% Original Macros
\def\email#1{\gdef\@email{\texttt{#1}}}
\def\homepage#1{\gdef\@homepage{\texttt{#1}}}
\def\mac#1{\textsf{#1}}
\def\URL#1{\texttt{#1}}
\def\src#1{\texttt{#1}}

% Dvipdfmx.def 
\def\dvipdfmxDefi{http://tex.dante.jp/ok/dvipdfmx/}
\def\dvipdfmxDefii{http://ftp.ktug.or.kr/KTUG/dvipdfmx/contrib/latex/}

\IfFileExists{dvipdfmx.def}{%
   \let \IfDvipdfmxDef = \empty \relax}{%
   \typeout{^^Jget dvipdfmx.def at \dvipdfmxDefi^^J
            or \dvipdfmxDefii^^J}%
   \def\IfDvipdfmxDef{Get \src{dvipdfmx.def} at \URL \dvipdfmxDefii \\ 
      or \URL \dvipdfmxDefi.}%
}

% Author Info
\author   {Th\'or Watanabe\thanks \@email \space \thanks \@homepage}
\title    {\mac{jlisting.sty}\\
          ---Japanese Localized Patch File of \mac{listings}---}
\email    {thor@tex.dante.jp}
\homepage {http://tex.dante.jp/typo/}
\date     {2006/02/20}

\makeatother

\begin{document}
\maketitle
%\IfDvipdfmxDef

\section{$B$A$g$C$H$7$?@bL@(B}% Short Description
 
$B1|B<@2I';a$N7G<(HD$N!VHFMQE*$JIbF0BN!W$H$$$&0lO"$N=q$-9~$_$+$i(B
$BE>:\$7$^$7$?!#(B

\begin{quote}
 \url{http://http://cise.edu.mie-u.ac.jp/~okumura/texfaq/qa/21172.html}\\
 \url{http://http://cise.edu.mie-u.ac.jp/~okumura/texfaq/qa/21184.html}\\
 \url{http://http://cise.edu.mie-u.ac.jp/~okumura/texfaq/qa/21189.html}\\
 \url{http://http://cise.edu.mie-u.ac.jp/~okumura/texfaq/qa/21197.html}
\end{quote}

 Copyright $B$O5H1JE/H~;a$K$"$k$N$@$H;W$$$^$9!%(B
 
\section{$B99?7MzNr(B}% ChageLogs

\begin{description}
 \item[ver.~0.1 (2004/03/24)]
   $B$H$j$"$($:8x3+!%(B
 \item[ver.~0.2 (2006/02/20)] 
   \verb|\lst@breakProcessOther| $BL?Na$NDj5A$NDI2C!%(B
\end{description}

\section{$B%=!<%9%3!<%I(B}
\par\narrowbaselines
\verbatiminput{jlisting.sty}
\end{document}
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