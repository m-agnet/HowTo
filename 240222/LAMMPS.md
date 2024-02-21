
# LAMMPS

## インストール方法

Homebrew を用いる. 

Homebrewのインストールはネットで調べると簡単にできる.

その上でターミナルに以下を実行.

```zsh
brew install lammps
```

`/opt/homebrew/share/lammps/examples/` にLAMMPSのサンプルが入っていれば成功.

## 実行コマンド

以下のコマンドをLAMMPSファイルのディレクトリ上で実行する.

LAMMPSファイルは「in.」 が接頭についている.

```zsh
mpirun -n 4 lmp_mpi -log output.log -in in.title
```

## 例として使用するファイル

- in.logo : 公式サイトにあるファイル.
- in.melt : サンプルmeltに入っているファイル.
- in.2dLJ : 私が実際に使っているコードの基本形. 

### in.logo

```zsh:in.logo
# LAMMPSロゴのシミュレーション


units		lj  # LJ単位系を設定
atom_style	atomic  # 原子スタイルを原子型に設定
dimension	2   # シミュレーションの次元を2Dに設定

# 低密度の2D格子を作成し、拡散を可能にする
# 格子は平方根2/2の正方形で、原点は(0.25, 0.25, 0.0)にシフトされている
lattice		sq2 0.5 origin 0.25 0.25 0.0
region		box block 0 31 0 7 -0.5 0.5 # シミュレーションボックス領域を定義
create_box	2 box   # 2種類の原子を持つシミュレーションボックスを作成
create_atoms	1 box   # タイプ1の原子をシミュレーションボックス内に作成

# LAMMPSロゴの各文字に対応する領域を定義
# 各領域は文字を形成する原子のサブセットを定義
region	        L1 block 2 3 1 6 -0.5 0.5
region	        L2 block 2 5 1 2 -0.5 0.5
region		L union 2 L1 L2

# 文字領域内の原子をタイプ2に変換する
set		region L type 2

# A、M(1M、2M)、P、Sの文字に対応する類似の領域が定義されている

region	        A1 block 6 7 1 6 -0.5 0.5
region	        A2 block 8 9 1 6 -0.5 0.5
region	        A3 block 6 9 3 4 -0.5 0.5
region	        A4 block 6 9 5 6 -0.5 0.5
region		A union 4 A1 A2 A3 A4

region	        1M1 block 10 11 1 6 -0.5 0.5
region	        1M2 block 14 15 1 6 -0.5 0.5
region	        1M3 block 10 15 5 6 -0.5 0.5
region	        1M4 block 12 13 3 6 -0.5 0.5
region		1M union 4 1M1 1M2 1M3 1M4

region	        2M1 block 16 17 1 6 -0.5 0.5
region	        2M2 block 20 21 1 6 -0.5 0.5
region	        2M3 block 16 21 5 6 -0.5 0.5
region	        2M4 block 18 19 3 6 -0.5 0.5
region		2M union 4 2M1 2M2 2M3 2M4

region	        P1 block 22 23 1 6 -0.5 0.5
region	        P2 block 24 25 3 6 -0.5 0.5
region	        P3 block 22 25 3 4 -0.5 0.5
region	        P4 block 22 25 5 6 -0.5 0.5
region		P union 4 P1 P2 P3 P4

region	        S1 block 26 29 5 6 -0.5 0.5
region	        S2 block 26 27 3 6 -0.5 0.5
region	        S3 block 26 29 3 4 -0.5 0.5
region	        S4 block 28 29 1 4 -0.5 0.5
region	        S5 block 26 29 1 2 -0.5 0.5
region		S union 5 S1 S2 S3 S4 S5

region          LAMMPS union 6 L A 1M 2M P S
set		region LAMMPS type 2


# 質量、ペアスタイル、ペア係数などのシステムパラメータを定義
mass		* 1.0
pair_style	lj/cut 2.5
pair_coeff	* * 1.0 1.0 2.5

# シミュレーションのタイムステップを設定
timestep        0.005
# 近接原子探索のスキンサイズとビンサイズを設定
neighbor	0.3 bin
# 近接リストの変更
neigh_modify	delay 0 every 1 check yes

# 全原子の速度を初期化
velocity	all create 2.0 87287 loop geom

# 熱力学情報の出力頻度を設定
thermo		100
# 20タイムステップごとに原子位置をscript.lammpstrjというファイルにダンプ
dump		1 all atom 20 output.lammpstrj

# 100ステップのシミュレーションを積分せずに実行して"一時停止"させる
run		100

# シミュレーションをNVEアンサンブルで実行し、2Dの制約を強制して格子を溶解させる
fix		1 all nve
fix		2 all enforce2d
run		1000

# インテグレータなしでシミュレーションを実行して、可視化を一時停止する
unfix		1
unfix		2
run		200

# 原子の速度を反転させ、シミュレーションを継続する
# ロゴと格子は丸め誤差内で再結合するはずです
variable        vxflip atom -vx
variable        vyflip atom -vy
velocity	all set v_vxflip v_vyflip NULL

fix		1 all nve
fix		2 all enforce2d
run		1000

# 再びインテグレータなしでシミュレーションを実行して可視化を一時停止する
unfix		1
unfix		2
run		100
```

### in.melt

```zsh
# 3次元のLennard-Jones溶融体

# LJ単位系を使用
units		lj

# 原子スタイルを原子型に設定
atom_style	atomic

# 粒子の初期配置: fcc格子を使用して, 数密度を0.8442に設定
lattice		fcc 0.8442
# シミュレーションボックス領域を定義
region		box block 0 10 0 10 0 10
# 1つのボックス内に1種類の原子を作成
create_box	1 box
# ボックス内に1つの原子を作成
create_atoms	1 box
# 原子の質量を設定
mass		1 1.0

# 全原子に初期速度を設定
velocity	all create 3.0 87287 loop geom

# LJポテンシャルをカットオフ半径2.5で適用
pair_style	lj/cut 2.5
# LJポテンシャルの係数を設定
pair_coeff	1 1 1.0 1.0 2.5

# 近接原子探索のスキンサイズとビンサイズを設定
neighbor	0.3 bin
# 近接リストの修正頻度を設定
neigh_modify	every 20 delay 0 check no

# NVEアンサンブルを用いて全原子を修正
fix		1 all nve

# 溶融体の原子の位置を50ステップごとにファイルにダンプ
dump		id all atom 50 output.lammpstrj

# 溶融体の状態を画像として25ステップごとにファイルにダンプ
dump		2 all image 25 image.*.jpg type type &
		axes yes 0.8 0.02 view 60 -30
# 画像のパディングを設定
dump_modify	2 pad 3

# 動画ファイルへの溶融体の状態のダンプ（コメントアウトされています）
# dump		3 all movie 25 movie.mpg type type &
#		axes yes 0.8 0.02 view 60 -30
# 動画のパディングを設定（コメントアウトされています）
# dump_modify	3 pad 3

# 熱力学情報の出力頻度を設定
thermo		50
# シミュレーションを250ステップ実行
run		250
```

### in.2dLJ

```zsh
# 2d Lennard-Jones


# 出力関係のパラメータ
variable        run equal 10000000
variable        thermo equal ${run}/1000 # 分母の数がlogで生成される行数になる.
variable        dump equal ${run}/1000 # 分母の数がlammpstrjで生成される行数になる.
variable        image_step equal ${run}/4 # 分母の数+1枚の画像を作成.

# 重要なパラメータ
variable        SEED equal 202035
variable        Ay equal 50 # 粒子生成に用いるy方向でのセル数.
variable        Ax equal ${Ay}/2 # 粒子生成に用いるx方向でのセル数.
variable        rho equal 0.4 # 密度. 密度と粒子数から体積が決まる.
variable        trange equal 5 # 各熱浴の幅.
variable        gap equal 0.5 # boxとcatomのずれ. ずらさないと粒子が消えてしまう.
# lo,hi が単に座標の小さい大きいであることに注意.
variable        T equal 0.43 # 各熱浴の目標温度の中間, これを初期温度に設定.
variable        dT equal 0.02
variable        thot equal ${T}+(${dT}/2) # 座標の小さい方の熱浴の目標温度.
variable        tcold equal ${T}-(${dT}/2) # 座標の大きい方の熱浴の目標温度.
variable        g equal 0.0004 # 重力加速度.
# 粒子-粒子間のLJポテンシャル
variable        epsilon_pair equal 1.0 # LJポテンシャルのepsilon; ポテンシャルの深さ.
variable        sigma_pair equal 1.0 # LJポテンシャルのsigma; 衝突直径.
variable        rc_pair equal 3.0 # 典型的なカットオフ長.
# 壁-粒子間のLJポテンシャル
variable        Rd equal 0.0 # 乾き具合.
variable        Rt equal 0.5 # 壁の厚み.
variable        Ra equal 1.877538 # 濡れ具合.
variable        epsilon_wall equal 1.0-${Rd} # LJポテンシャルのepsilon; ポテンシャルの深さ.
variable        sigma_wall equal 0.5+${Rt} # LJポテンシャルのsigma; 衝突直径.
variable        rc_wall equal 1.122462+${Ra} # WCAポテンシャルになるようなカットオフ長+alpha*sigma_wall.

# 領域関係のパラメータ
  # 縦長のとき
variable        box_xlo equal 0 # xの小さい方の直線.
variable        box_xhi equal ${Ax} # xの大きい方の直線.
variable        box_ylo equal -${gap} # yの小さい方の直線.
variable        box_yhi equal ${Ay}-${gap} # yの大きい方の直線.
variable        hotlo equal -${gap} #  熱浴で温度の低い方の小さい方の直線.
variable        hothi equal -${gap}+${trange} # 熱浴で温度の低い方の大きい方の直線.
variable        coldlo equal ${Ay}-${gap}-${trange} # 熱浴で温度の高い方の小さい方の直線.
variable        coldhi equal ${Ay}-${gap} # 熱浴で温度の高い方の大きい方の直線.

# 系の設定
units		        lj # LJ単位系.
atom_style	    atomic # 粒子.
dimension       2 # 次元.
timestep        0.005 # MDシミュレーションのtimestep.
boundary        p f p # x=l,y=m,z=nの直線が周期境界条件.
lattice		      sq ${rho} # 粒子の初期配置. sq; 正方形セルの左隅に1つ置く.
region		      box block ${box_xlo} ${box_xhi} ${box_ylo} ${box_yhi} -0.1 0.1 # 系の領域設定.
region          catom block 0 ${Ax} 0 ${Ay} -0.1 0.1 # 粒子生成の領域設定.
create_box	    1 box # 系の生成.
create_atoms    1 region catom # 粒子の生成.
mass		        1 1.0 # 粒子の設定.
velocity	      all create ${T} ${SEED} dist gaussian # 粒子に温度tを目標とする初期速度をガウス分布に従って与える.

  # 縦長のとき
region          cold block INF INF ${coldlo} ${coldhi} -0.1 0.1 # 熱浴Cの領域.
region          hot block  INF INF ${hotlo} ${hothi} -0.1 0.1 # 熱浴Hの領域.

# 各熱浴領域の温度を計算
compute         Tcold all temp/region cold # c_Tcoldでcold熱浴領域の温度を取得.
compute         Thot all temp/region hot # c_Tcoldでcold熱浴領域の温度を取得.

# 粒子-粒子間相互作用ポテンシャル
pair_style lj/cut ${rc_pair}
pair_coeff	    1 1 ${epsilon_pair} ${sigma_pair} ${rc_pair}
pair_modify     shift yes # ポテンシャルエネルギーが0になる距離がカットオフ長になるように全体的にシフトアップする.

# 高速化コマンド. neighbor list に入れる距離指定.
neighbor	      0.3 bin
neigh_modify    every 1 delay 0 check yes

# システムに他の操作がない場合にnveアンサンブルに一致するだけで, 今回の系はlangevin 熱浴を用いた nvt アンサンブルであることに注意.
fix		          1 all nve

# 壁-粒子間相互作用ポテンシャル
# 縦長のとき
fix             wallylo all wall/lj126 ylo EDGE ${epsilon_wall} ${sigma_wall} ${rc_wall} units box pbc yes
fix             wallyhi all wall/lj126 yhi EDGE ${epsilon_wall} ${sigma_wall} ${rc_wall} units box pbc yes

# langevin 熱浴
fix             hot all langevin ${T} ${T} 1.0 ${SEED} tally no # 熱浴Hが温度Tになるようにする.
fix             cold all langevin ${T} ${T} 1.0 ${SEED} tally no # 熱浴Cが温度Tになるようにする.
fix_modify      hot temp Thot
fix_modify      cold temp Tcold

# 重力場
fix             Gravity all gravity ${g} vector 0 -1 0

# 重力のみで緩和させるとき
# run             200000 # 重力のみでの平衡までの緩和時間
# unfix           hot # 熱浴Hについての設定の解除.
# unfix           cold # 熱浴Cについての設定の解除.

fix             hot all langevin ${thot} ${thot} 1.0 ${SEED} tally no # 熱浴が温度tloになるようにする.
fix             cold all langevin ${tcold} ${tcold} 1.0 ${SEED} tally no # 熱浴が温度thiになるようにする.
fix_modify      hot temp Thot
fix_modify      cold temp Tcold

# 重心計算(Center of Mass)
compute         CoM all com # c_CoM[1]でXg, c_CoM[2]でYgを取得.


# 出力コマンド
# VMD
dump		    id all custom ${dump} output.lammpstrj id x y vx vy

# 画像
dump		    2 all image ${image_step} image.*.jpg type type
dump_modify	    2 pad 3

# log
thermo_style    custom step time temp pe ke etotal c_CoM[2] # 出力する物理量.

# YAML
fix             extra all print ${thermo} """
- step: $(step)
  time: $(time)
  temp: $(temp)
  ke: $(ke)
  pe: $(pe)
  etotal: $(etotal)
  Yg: $(c_CoM[2])""" file output.yaml screen no

# #  一次元プロファイル（今は温度と密度だけ計算と出力）
# compute         chunk all chunk/atom bin/1d y lower 3.0 units box
# fix             tempp all ave/chunk 100000 1 100000 chunk temp file temp_profile.profile
# fix             rhop all ave/chunk 100000 1 100000 chunk density/number file rho_profile.profile

thermo		      ${thermo} # 熱力学量の出力.
thermo_modify norm no # 示量的な熱力学量に調整.

run		          ${run} # 実行.
```

## 参考になる記事

[Pythonを用いて, 初期条件を指定する方法.](https://zenn.dev/kaityo256/articles/md_initial_condition)