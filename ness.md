# 計算機の使い方 -簡易ver.-

## 想定する読者

- とりあえず計算機クラスターを使ってみたい!!という人を対象としている.
- 具体的にコマンドを例示しているので, 適宜変更して使うこと.

## ness1 への入りかた.

ターミナルで以下を実行する.

```zsh
ssh r.yamamoto@ness1.sci.ibaraki.ac.jp
```

## ness1 に入った状態でよく使うコマンド集.

よく使うコマンドをピックアップした. 

* 適当に空いているところを探してジョブを投入.

    ```zsh
    myqsub -Q ness -C 4 mpirun -n 4 lmp_mpi -in {lammpsfile} 
    例: myqsub -Q ness -C 4 mpirun -n 4 lmp_mpi -in in.melt 
    ```


* 計算機の計算状況の一覧が出力される.

    ```zsh
    qstat -f 
    ```

* ジョブの状況が出力される.

    ```zsh
    qstat -u "*" 
    ```


* runを確認. cmd+Cで抜ける.

    ```zsh
    qpeek -f {jobID}
    例: qpeek -f 202035
    ```

* 指定のジョブを取り消し.

    ```zsh
    qdel {jobID}
    例: qdel 202035
    ```


## ローカルとリモートでのファイルのやりとり.

ssh接続していないターミナルで実行する.  なぜ`*`と`-r`が双方向で使えないのかはわからない. (ネットで調べる限りできそうなのだが...)

* ローカルからリモートにファイルをコピペ. 
  * ワイルドカード`*`を使うことができる.

    ```zsh
    scp lammps_modexe.jl {USER}@ness1:~/path
    例: scp lammps_modexe.jl r.yamamoto@ness1:~/Research/colection/
    ```

* リモートからローカルにファイルをコピペ. 
  * ディレクトリごとに動かす`-r`を使うことができる.

    ```zsh
    scp -r {USER}@ness1:~/path {localpath}
    例: scp -r r.yamamoto@ness1:~/Research/outputdir/lammpstrjdir ~/Desktop/r_yamamoto/outputdir_ssh/
    ```