# 標準偏差グラフ描画セル, 横軸Ra
# パッケージ
using Plots
using YAML
using Statistics

function extract_ra_rt_values(file_path)
    # 正規表現を使ってRtとRaの値を抽出する
    regex_pattern = r"Rt([\d.]+)_Ra([\d.]+)"
    match_result = match(regex_pattern, basename(file_path))
    
    if match_result !== nothing
        # タプルとしてRtとRaの値を返す
        rt_value = parse(Float64, match_result.captures[1])
        ra_value = parse(Float64, match_result.captures[2])
        return (rt_value, ra_value)
    else
        # マッチしない場合は `nothing` を返す
        return (nothing, nothing)
    end
end

function plot_lnstd_vs_Ra_for_different_Rt(yaml_directory)
    # YAMLファイルのパスをフィルタリング
    yaml_file_paths = filter(x -> occursin(".yaml", x), readdir(yaml_directory))

    # Rt-Ra毎のデータを保持する辞書
    rt_ra_data = Dict{Tuple{Float64, Float64}, Vector{Float64}}()

    # 各YAMLファイルからデータを抽出してグループ化
    for yaml_file_path in yaml_file_paths
        rt, ra = extract_ra_rt_values(yaml_file_path)
        if rt !== nothing && ra !== nothing
            data = YAML.load_file(joinpath(yaml_directory, yaml_file_path))
            Yg_values = [entry["Yg"] for entry in data if entry["time"] > 25000]
            std_Yg = std(Yg_values)
            ln_std_Yg = log(std_Yg)
            key = (rt, ra)
            # 辞書にデータを追加または新規追加する
            if haskey(rt_ra_data, key)
                push!(rt_ra_data[key], ln_std_Yg)
            else
                rt_ra_data[key] = [ln_std_Yg]
            end
        end
    end

    # Rt値を昇順にソート
    sorted_rt_values = sort(unique([key[1] for key in keys(rt_ra_data)]))

    # Rt値の小さい順にプロット
    plot()
    # ラベルやタイトルの設定
    xlabel!("Ra")
    ylabel!("ln Standard Deviation of Yg")
    title!("ln Standard Deviation of Yg vs. Ra for different Rt")
    for rt in sorted_rt_values
        # 各Rtに属するRa値をソート
        ra_values_for_rt = [key[2] for key in keys(rt_ra_data) if key[1] == rt]
        sorted_ra_values = sort(ra_values_for_rt)

        # プロットデータを準備
        sorted_std_Yg_values = [rt_ra_data[(rt, ra)][1] for ra in sorted_ra_values]

        # Rt毎のグラフをプロット
        plot!(sorted_ra_values, sorted_std_Yg_values, label="Rt=$(rt)", marker=:circle, line=:dash)
    end


end

# プロット関数の実行
yaml_directory = "/Users/2023_2gou/Desktop/r_yamamoto/Research/outputdir_nas/231114outputdir/yamldir"
plot_lnstd_vs_Ra_for_different_Rt(yaml_directory)

display(plot!())
# savefig("lnStdYg_Ra_ti25000")

ccall(:jl_tty_set_mode, Int32, (Ptr{Cvoid}, Int32), stdin.handle, true)
read(stdin, 1)