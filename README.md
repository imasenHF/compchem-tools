# Computational Chemistry Tools

一组用于 Gaussian、ORCA、CP2K 与 Multiwfn 工作流的 Bash/Python 小工具，覆盖批处理、结果提取、输入文件生成、格式转换和可视化。

公开署名：hyphoon  
联系：wuhaifeng@ustc.edu.cn

## 目录

- `scripts/analysis/`：Multiwfn 波函数与性质分析，包括 ESP、conceptual DFT、hole–electron、IRI/IGMH、自旋密度、轨道和键级等。
- `scripts/extract/`：从 Gaussian、ORCA、CP2K 或 Shermo 文本输出中提取能量、热校正、激发态与计算时间。
- `scripts/convert/`：结构/波函数文件批量转换。
- `scripts/input/`：Gaussian、ORCA、CP2K 输入文件及约束片段辅助。
- `scripts/render/`：POV-Ray、ffmpeg、VMD/Tachyon 与 UV–vis 绘图辅助。
- `scripts/hpc/`：Gaussian 集群运行示例。
- `scripts/misc/`：批量改名、坐标替换等工具。

完整脚本索引见 `docs/SCRIPT_INDEX.md`。

## 使用

大多数脚本直接处理当前目录中的文件。例如：

```bash
./scripts/convert/log2xyz.sh
./scripts/extract/getorcaE.sh
./scripts/input/orcacons.sh "2,7-8,10,21-28"
```

可将常用脚本目录加入 `PATH`，也可以为单个脚本建立 alias。

## 依赖

不同脚本的依赖不同，并非全部必需。常见外部程序包括：

- Multiwfn
- Gaussian 09/16
- ORCA
- CP2K
- Shermo
- OfakeG
- ffmpeg
- POV-Ray
- VMD / Tachyon

`UVvis_plot.py` 使用 pandas 和 matplotlib。

脚本默认外部命令可从 `PATH` 调用。Multiwfn 相关脚本依赖其交互菜单编号，版本变化后应重新检查。

## 使用限制

部分脚本包含固定的计算级别、原子范围、温度、激发态数或目录命名约定。使用前应先检查脚本头部注释和具体参数。

涉及能量、热力学修正、波函数分析或几何修改时，建议先在副本目录测试，并核对程序版本、输入格式、单位和输出文本。

部分脚本会直接修改或重命名当前目录中的文件，具体行为见脚本头部注释和索引。

## License

[MIT License](LICENSE).
