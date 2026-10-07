# Script index

本表依据当前脚本行为整理；“依赖”只列主要外部程序。

## Wavefunction / property analysis

| File | Purpose | I/O | Dependencies | Notes |
|---|---|---|---|---|
| `getCDFT.sh` | 基于 N、N+1、N-1 Gaussian fchk 文件调用 Multiwfn 计算概念 DFT 描述符。 | *_N.fchk + 对应 N±1 文件 -> CDFT/ | Multiwfn | 文件命名和 Multiwfn 菜单序列固定。 |
| `getCDFT4orca.sh` | 基于 N、N+1、N-1 波函数文件调用 Multiwfn 计算概念 DFT 描述符。 | *_N.wfn + 对应 N±1 文件 -> CDFT/ | Multiwfn | 面向 ORCA 工作流的 WFN 文件命名约定。 |
| `getESP.sh` | 对 Gaussian fchk 批量执行电子密度、静电势与分子表面相关分析。 | *.fchk -> 每体系子目录 | Multiwfn | ESP 单位可用参数 eV、kcal/mol 或 kJ/mol；菜单序列固定。 |
| `getESP4orca.sh` | 对 ORCA Molden 文件批量执行电子密度、静电势与分子表面相关分析。 | *.molden -> 每体系子目录 | Multiwfn | ESP 单位可用参数 eV、kcal/mol 或 kJ/mol；菜单序列固定。 |
| `getEleHole.sh` | 对 Gaussian 激发态结果批量执行 hole–electron 分析并整理 cube 文件。 | *.fchk + 同名 *.log -> 每体系子目录 | Multiwfn | 当前脚本分析前 4 个激发态。 |
| `getEleHole_4orca.sh` | 对 ORCA 激发态结果批量执行 hole–electron 分析并整理 cube 文件。 | *.molden + 同名 *.out -> 每体系子目录 | Multiwfn | 当前脚本分析前 10 个激发态。 |
| `getEleHole_frag.sh` | 按片段定义对 Gaussian 激发态执行 hole–electron 分解分析。 | *.fchk + *.log + *_frag.txt -> *.txt | Multiwfn | 默认处理 10 个激发态；片段定义文件名固定。 |
| `getIGMH.sh` | 对 Molden 波函数批量执行 Multiwfn IGMH/相互作用分析流程。 | *.molden -> 每体系子目录 | Multiwfn | 原子范围、距离与等值面相关参数写死在脚本中。 |
| `getIGMH4orca.sh` | 对 ORCA Molden 波函数批量执行 Multiwfn IGMH/相互作用分析流程。 | *.molden -> 每体系子目录 | Multiwfn | 与 getIGMH.sh 使用相同菜单流程，保留作为 ORCA 命名入口。 |
| `getIR.sh` | 使用 Multiwfn 从 Gaussian 输出批量生成红外光谱线谱与展宽曲线。 | *.log -> 每体系 *_line.txt / *_curve.txt | Multiwfn | 频率范围与展宽参数写在菜单输入中。 |
| `getIRI.sh` | 使用 Multiwfn 对 Molden 波函数批量生成 IRI 相关 cube 数据。 | *.molden -> 每体系子目录 | Multiwfn | 菜单序列固定。 |
| `getNBO.sh` | 从 NBO .31 文件批量导出指定轨道的 cube 文件。 | *.31 -> 每体系子目录 | Multiwfn | 第一个命令行参数用于指定轨道。 |
| `getOESP.sh` | 对 Molden 波函数批量执行电子密度、静电势与分子表面相关分析。 | *.molden -> 每体系子目录 | Multiwfn | 与 ORCA/Molden 工作流配套。 |
| `getOgap.sh` | 从 Molden 波函数批量读取 Multiwfn 输出的轨道能级信息。 | *.molden -> HOMO_LUMO | Multiwfn | 通过静默启动输出中的 eV 行提取。 |
| `getOorb.sh` | 从 Molden 波函数批量生成指定轨道的 cube 文件。 | *.molden -> cub/ | Multiwfn | 第一个命令行参数用于指定轨道。 |
| `getSpinDensity.sh` | 从 Gaussian fchk 批量生成自旋密度相关 cube/图像/文本。 | *.fchk -> 每体系子目录 | Multiwfn | 会移动当前目录中匹配的 *.cub、*.png 和 output.txt。 |
| `getSpinDensity4orca.sh` | 从 ORCA Molden 文件批量生成自旋密度相关 cube/图像/文本。 | *.molden -> 每体系子目录 | Multiwfn | 会移动当前目录中匹配的 *.cub、*.png 和 output.txt。 |
| `getbondorder.sh` | 使用 Multiwfn 对 Molden 波函数批量计算键级矩阵。 | *.molden -> *_bndmat.txt | Multiwfn | 输出依赖 Multiwfn bndmat.txt。 |
| `getgap.sh` | 从 Gaussian fchk 批量读取 Multiwfn 输出的轨道能级信息。 | *.fchk -> HOMO_LUMO.txt | Multiwfn | 通过静默启动输出中的 eV 行提取。 |
| `getorb.sh` | 从 Gaussian fchk 批量生成指定轨道的 cube 文件。 | *.fchk -> cub/ | Multiwfn | 第一个命令行参数用于指定轨道。 |

## Text extraction

| File | Purpose | I/O | Dependencies | Notes |
|---|---|---|---|---|
| `cp2kEt.sh` | 从 CP2K 输出中批量提取 Total energy 并写入制表符分隔文件。 | *.out -> Et.txt | grep, awk | 按“Total energy:”文本匹配。 |
| `getBSSE.sh` | 从 Gaussian 输出批量提取 BSSE energy。 | *.log -> BSSE_E.txt | grep, sed | 依赖 Gaussian 输出中的固定文本。 |
| `getGGcorr.sh` | 从 Gaussian 输出提取 Thermal correction to Gibbs Free Energy。 | *.log -> Gibbs_corr.txt | grep, sed | 基于固定输出文本。 |
| `getGcorr.sh` | 调用 Shermo 批量计算 Gaussian 频率输出的 Gibbs 热校正。 | *.log -> getGall.txt | Shermo.exe | 温度与低频处理参数写在脚本中。 |
| `getHF.sh` | 从 Gaussian archive 段批量提取 HF energy。 | *.log -> HF.txt | grep, sed | 依赖 Gaussian archive 文本格式。 |
| `getOGcorr.sh` | 调用 Shermo 批量计算 ORCA 输出的 Gibbs 热校正。 | *.out -> getGall.txt | Shermo.exe | 温度等参数使用 Shermo 默认值/脚本设置。 |
| `getTD.sh` | 从 ORCA 输出批量收集激发态 STATE 行。 | *.out -> tdState.txt | grep | 用于快速汇总 TD/激发态文本。 |
| `getTotalE.sh` | 从 CP2K 输出批量提取 Total energy。 | *.out -> getTotalE.txt | grep, uniq | 基于“Total energy:”文本匹配。 |
| `getorcaE.sh` | 从 ORCA 输出批量提取最后一次 FINAL SINGLE POINT ENERGY。 | *.out -> getTotalE.txt | grep, uniq | 输出文件沿用历史名称 getTotalE.txt。 |
| `getorcaG.sh` | 从 ORCA 输出批量提取 Final Gibbs free energy 与 G-E(el)。 | *.out -> orcaG.txt | grep | 基于 ORCA 固定文本匹配。 |
| `total_time.sh` | 批量收集 Gaussian LOG 中的 Job cpu time。 | *.log -> total_time.txt | grep | 只汇总 CPU time 文本。 |

## Format conversion

| File | Purpose | I/O | Dependencies | Notes |
|---|---|---|---|---|
| `OfakeG.sh` | 调用 OfakeG.exe 批量将 ORCA 输出转换为可供部分 Gaussian 工作流读取的伪 Gaussian 输出。 | *.out -> 由 OfakeG.exe 决定 | OfakeG.exe | 外部程序不随本项目分发。 |
| `fchk2pdb.sh` | 通过 Multiwfn 批量将 Gaussian formatted checkpoint 转换为 PDB。 | *.fchk -> *.pdb | Multiwfn | 要求 Multiwfn 可从 PATH 调用。 |
| `gjf2cif.sh` | 使用 Multiwfn 批量将 GJF 转换为 CIF。 | *.gjf -> *.cif | Multiwfn | 格式转换依赖 Multiwfn 主功能 100。 |
| `gjf2pdb.sh` | 使用 Multiwfn 批量将 GJF 转换为 PDB。 | *.gjf -> *.pdb | Multiwfn | 格式转换依赖 Multiwfn 主功能 100。 |
| `gjf2xyz.sh` | 使用 Multiwfn 批量将 GJF 转换为 XYZ。 | *.gjf -> *_EDAw.xyz | Multiwfn | 保留历史输出后缀 _EDAw.xyz。 |
| `log2cif.sh` | 使用 Multiwfn 批量将 Gaussian LOG 转换为 CIF。 | *.log -> *.cif | Multiwfn | 格式转换依赖 Multiwfn。 |
| `log2gjf.sh` | 使用 Multiwfn 提取 Gaussian LOG 最终几何并批量写为 GJF。 | *.log -> *.gjf | Multiwfn | 适用于后续单点或其他计算的结构转存。 |
| `log2pdb` | 使用 Multiwfn 批量将 Gaussian LOG 转换为 PDB。 | *.log -> *.pdb | Multiwfn | 历史文件名未带 .sh 后缀。 |
| `log2xyz.sh` | 使用 Multiwfn 批量将 Gaussian LOG 转换为 XYZ。 | *.log -> *.xyz | Multiwfn | 格式转换依赖 Multiwfn。 |
| `out2cif.sh` | 使用 Multiwfn 批量将 OUT 文件转换为 CIF。 | *.out -> *.cif | Multiwfn | 适用于 Multiwfn 能识别的输出文件。 |
| `out2gjf.sh` | 使用 Multiwfn 批量从 OUT 文件提取几何并写为 GJF。 | *.out -> *.gjf | Multiwfn | 适用于 Multiwfn 能识别的输出文件。 |
| `out2xyz.sh` | 使用 Multiwfn 批量将 OUT 文件转换为 XYZ。 | *.out -> *.xyz | Multiwfn | 适用于 Multiwfn 能识别的输出文件。 |
| `xyz2gjf.sh` | 使用 Multiwfn 批量将 XYZ 转换为 Gaussian GJF。 | *.xyz -> *.gjf | Multiwfn | 输出计算级别仍需人工检查。 |

## Input generation

| File | Purpose | I/O | Dependencies | Notes |
|---|---|---|---|---|
| `cp2kinp.sh` | 通过 Multiwfn 批量从 GJF 生成 CP2K 输入文件。 | *.gjf -> *.inp | Multiwfn | Multiwfn 菜单序列及 CP2K 参数写死在脚本中，使用前需核对。 |
| `gjftemp.sh` | 批量重写 GJF 计算头并保留原几何部分。 | *.gjf -> 原地修改 | sed | 计算级别、资源、总电荷和多重度均为固定示例；会覆盖文件。 |
| `orcacons.sh` | 根据 1-based 原子编号/区间生成 ORCA %geom Constraints 片段。 | 参数如 2,7-8,10 -> 标准输出 | bash | 输出中自动换算为 ORCA 使用的 0-based 索引。 |
| `orcatemp.sh` | 生成固定 ORCA 模板，并通过 Multiwfn 从现有结构/波函数文件创建单点输入。 | *.fchk/*.log/*.out -> *_sp.inp | Multiwfn | 方法与资源参数固定为示例，使用前必须核对。 |

## Rendering / plotting

| File | Purpose | I/O | Dependencies | Notes |
|---|---|---|---|---|
| `UVvis_plot` | 从脚本所在目录调用 UVvis_plot.py。 | 交互式 | Python | 已改为相对脚本目录调用，移除个人绝对路径。 |
| `UVvis_plot.py` | 读取表格型 UV–vis 数据，执行参考波长基线平移、三列一组平均并导出 CSV/PDF。 | xlsx/xls/csv/txt -> *_std.csv + *.pdf | Python, pandas, matplotlib | 假定每组三列为重复测量；参考波长采用精确数值匹配。 |
| `png2gif.sh` | 将 FRAME%04d.png 图像序列编码为 GIF。 | FRAME*.png -> video.gif | ffmpeg | 默认 15 fps；会覆盖 video.gif。 |
| `png2mp4.sh` | 将 FRAME%04d.png 图像序列编码为 MP4。 | FRAME*.png -> video.mp4 | ffmpeg | 默认 15 fps、CRF 22；会覆盖 video.mp4。 |
| `pov2gif.sh` | 批量渲染 POV-Ray 文件为 PNG，并编码为 GIF。 | *.pov -> *.png + video.gif | POV-Ray, ffmpeg | 文本渲染可能需要脚本目录中的字体文件；字体不随项目分发。 |
| `pov2mp4.sh` | 批量渲染 POV-Ray 文件为 PNG，并编码为 MP4。 | *.pov -> *.png + video.mp4 | POV-Ray, ffmpeg | 文本渲染可能需要脚本目录中的字体文件；字体不随项目分发。 |
| `pov2png.sh` | 批量使用 POV-Ray 渲染当前目录的 POV 文件。 | *.pov -> *.png | POV-Ray | 文本渲染可能需要脚本目录中的字体文件；字体不随项目分发。 |
| `vmdrender.sh` | 使用 VMD/Tachyon 生成的 DAT 场景批量渲染 MO/ESP 图像。 | *.dat -> *.bmp | tachyon_WIN64.exe | 支持 MO、ESP、MO_low 模式及可选分辨率。 |

## HPC examples

| File | Purpose | I/O | Dependencies | Notes |
|---|---|---|---|---|
| `g09.sh` | Gaussian 09 的集群提交/运行示例模板。 | 单个 GJF -> Gaussian 输出 | Gaussian 09, scheduler launcher | 已移除原机器绝对路径；需按集群环境配置。 |
| `g16.sh` | 批量运行当前目录的 Gaussian 16 GJF，并对 checkpoint 执行 formchk。 | *.gjf -> *.out, *.fchk | Gaussian 16, formchk | 直接遍历当前目录所有 GJF。 |
| `sub.sh` | Gaussian 09 的 SLURM 提交脚本示例。 | 单个 GJF -> LOG/FCHK | SLURM, Gaussian 09, formchk | 已移除原账户与绝对路径；需设置 G09_ROOT。 |

## Miscellaneous

| File | Purpose | I/O | Dependencies | Notes |
|---|---|---|---|---|
| `4insert.sh` | 批量修改 Gaussian GJF 头部资源参数，并在第 4 行追加 IOp(9/40=4) 与 guess=read。 | *.gjf -> 原地修改 | sed | 会直接修改输入文件；参数固定，使用前应检查计算设置。 |
| `braD.sh` | 删除当前目录 GJF 文件中括号及括号内文本。 | *.gjf -> 原地修改 | sed | 会直接修改输入文件；正则规则较宽，建议先备份。 |
| `rename.sh` | 按扩展名筛选文件，并把指定末尾字符串替换为新字符串。 | 参数: ext old_suffix new_suffix -> 原地重命名 | mv | 批量改名不可逆，使用前先检查命令输出。 |
| `tat.sh` | 用 xtbopt.xyz 中的坐标替换指定 Gaussian GJF 中已有坐标块。 | xtbopt.xyz + H2O_org.gjf -> 原地修改 | grep, sed | 文件名固定且会改写 GJF；适合个人工作流示例。 |