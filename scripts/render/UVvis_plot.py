"""读取表格型 UV–vis 数据，执行参考波长基线平移、三列一组平均并导出 CSV/PDF。

This is a small interactive plotting helper retained from a personal computational-chemistry workflow.
"""

import pandas as pd
import matplotlib.pyplot as plt

# 根据文件类型读取数据
file_path = input("请输入文件路径：")
from pathlib import Path
file_name = Path(file_path).name
if file_name.endswith('.xlsx') or file_name.endswith('.xls'):
    data = pd.read_excel(file_path)
elif file_name.endswith('.csv'):
    data = pd.read_csv(file_path)
elif file_name.endswith('.txt'):
    data = pd.read_table(file_path, delimiter='\t')

# 输入标签名
label_input = input("请输入图例名（格式为label1,label2,label3，直接输入Enter使用输入文件中的第一行标题）：")
if label_input:
    labels = label_input.split(",")
else:
    labels = list(data.iloc[0, 1:])

# 跳过第一行
data = data.iloc[1:].reset_index(drop=True)

# 获取波长数据（第一列）
wavelengths = data.iloc[:, 0]

# 获取吸光度数据（除第一列之外的所有列）
absorbance_data = data.iloc[:, 1:]

# 定义线条颜色
colors = ['#BC3C29FF', '#0072B5FF', '#E18727FF', '#20854EFF', '#7876B1FF', '#6F99ADFF', '#FFDC91FF', '#EE4C97FF']

# 创建一个图形窗口和坐标轴对象
fig, ax = plt.subplots()

# 调整图形边距
plt.subplots_adjust(left=0.16, right=0.96, top=0.92, bottom=0.12)

# 设置图形尺寸为正方形
fig.set_size_inches(6, 6)

found_match = False  # 标志变量，表示是否找到匹配行
while not found_match:
    wavelength_value = float(input("请输入波长值："))
    # 在波长数据中查找匹配的行
    numeric_wavelengths = pd.to_numeric(wavelengths, errors='coerce')
    matches = numeric_wavelengths[numeric_wavelengths == wavelength_value].index
    # 检查是否找到精确匹配的行
    if len(matches) > 0:
        row_index = matches[0]
        absorbance_data = absorbance_data.sub(absorbance_data.loc[row_index])
        print("找到波长为 {} 的行，已减去该行数据".format(wavelength_value))
        found_match = True  # 找到匹配行，修改标志变量，退出循环
    else:
        print("未找到波长为 {} 的行".format(wavelength_value))

min_absorbance = absorbance_data.min().min()  # 获取吸光度数据的最小值
absorbance_data += abs(min_absorbance)  # 调整所有值为大于等于0

# 创建DataFrame对象
df_A = pd.DataFrame(wavelengths)
df_A = df_A.rename(columns=dict(zip(df_A.columns, ['wavelength (nm)'])))
df_B = pd.DataFrame(absorbance_data)
df_B = df_B.rename(columns=dict(zip(df_B.columns, labels)))
df_combined = pd.concat([df_A, df_B], axis=1)
df_combined.to_csv(f'{file_name}_std.csv', index=False)

# 对每一组数据求平均值并绘制吸光度曲线
for i in range(0, len(absorbance_data.columns), 3):
    absorbance_columns = absorbance_data.columns[i:i+3]  # 每三列吸光度数据
    label = labels[i//3 % len(labels)]  # 对应组的标签，循环使用输入的标签
    color = colors[i//3 % len(colors)]  # 对应组的线条颜色，循环使用配色方案
    average_absorbance = absorbance_data[absorbance_columns].mean(axis=1)  # 求每组数据的平均值
    ax.plot(wavelengths, average_absorbance, label=label, color=color)

# 设置图例
ax.legend()
ax.legend(frameon=False, fontsize=14)

# 设置图表标题和轴标签
ax.set_title('UV-vis Spectrum', fontsize=20)
ax.set_xlabel('Wavelength', fontsize=18)
ax.set_ylabel('Absorbance', fontsize=18)

ax.tick_params(axis='x', labelsize=14)
ax.tick_params(axis='y', labelsize=14)

# 设置分辨率为300dpi，并保存图形为PDF
fig.savefig(f'{file_name}.pdf', dpi=300, format='pdf')

# 显示图表
plt.show()