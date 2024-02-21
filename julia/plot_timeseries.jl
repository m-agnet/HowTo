# 汎用時系列グラフ描画セル

# ライブラリ
using Plots
using YAML

function plot_data(yaml_file_path)
    # YAMLファイルを読み取る
    data = YAML.load_file(yaml_file_path)

    # 各データポイントから必要なデータを抽出
    step = [entry["step"] for entry in data]
    time = [entry["time"] for entry in data]
    
    temp_value = [entry["temp"] for entry in data]
    pe_value = [entry["pe"] for entry in data]
    ke_value = [entry["ke"] for entry in data]
    etotal_value = [entry["etotal"] for entry in data]
    Yg_value = [entry["Yg"] for entry in data]

    x_value = time
    y_value = Yg_value/80
    # グラフを描画
    plot!(x_value, y_value, label="Yg $(basename(yaml_file_path))",legend=:outerbottom)
end

# グラフの雛形
plot(xlabel="time", ylabel="Yg/Ly", title="Yg vs. time")

# 複数のパスに手動で対応
yaml_file_paths = [
    # 追加の YAML ファイルパスをここに追加
    "/Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir_ness/231126outputdir/yamldir/2023-11-22T18:19:27.787_RaRt_chi1.265_Ay50_rho0.4_T0.43_dT0.04_Rd0.0_Rt0.5_Ra0.938769_g0.0003999718779659611_run1.2e8.yaml"
]


for yaml_file_path in yaml_file_paths
    plot_data(yaml_file_path)
end

# グラフを表示
display(plot!())
# savefig("")

ccall(:jl_tty_set_mode, Int32, (Ptr{Cvoid}, Int32), stdin.handle, true)
read(stdin, 1)