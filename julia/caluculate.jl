# lammps 上での設定.
Ay = 10
Ax = Ay/2
rho = 0.4
# 粒子数の決定(sq)
N = Ax * Ay
# 体積の決定
V = N / rho
# シミュレーションBOX縦横の長さ計算
Lx = Ax / sqrt(rho)
Ly = Ay / sqrt(rho)
T = 0.43
dT = 0.04
TH = T + dT/2
TL = T - dT/2
g = 2e-4 # 仮に定める.
kB = 1.0
m = 1.0
# chi=12.65になるために必要なgの値.
function ex_mg()
    y = (kB*dT)/(Ly*12.65)
    return y
end

# 出力
println("N = $(N)")
println("Lx = $(Lx)")
println("Ly = $(Ly)")
println("χ=12.65になるためのmg=$(ex_mg())")
println("χ=1.265になるためのmg=$(ex_mg()*10)")