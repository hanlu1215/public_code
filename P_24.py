import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import os
import tkinter as tk
from tkinter import filedialog
root = tk.Tk()
root.withdraw()
#file_path = filedialog.askdirectory()
file_path = filedialog.askopenfilename()
print(file_path)
# 使用os.path.split()拆分路径
directory_path, videoPath = os.path.split(file_path)
os.chdir(directory_path)   #修改当前工作目录

Vol = 24
file_names = ['RigolDS1', 'RigolDS2', 'RigolDS3', 'RigolDS4', 'RigolDS5', 'RigolDS6']
n = len(file_names)
Ps = np.zeros(n)
fs = np.zeros(n)
P_times = [10, 10, 10, 10, 10, 10, 10, 10]

# Define the processing and plotting function
def pro_data_and_plot(file_name, k, n, Vol, P_times):
    plt.subplot(n, 1, k+1)
    data = pd.read_csv(f"{file_name}.csv")
    
    Vs = data.iloc[:, 1]
    Ts = data.iloc[:, 0]
    Ts = Ts - Ts.iloc[0]
    Is = P_times * Vs / 0.5 # 电压转为电流，
    
    plt.plot(Ts, Is, '.-')
    W = np.trapz(Vol * Is, Ts)
    P = abs(W / Ts.iloc[-1])
    title_str = f"{file_name}  P = {P} W"
    plt.title(title_str)
    plt.xlabel("t/s")
    plt.ylabel("I/A")
    plt.xlim([0, 2])
    
    return P

# Process each file
for k in range(n):
    Ps[k] = pro_data_and_plot(file_names[k], k, n, Vol, P_times[k])
    print(file_names[k])
    print(f'P = {Ps[k]}W')
    num_str = ''.join(filter(str.isdigit, file_names[k]))
    fs[k] = float(num_str)

# Save data to Excel
csv_save_file_path = 'P_python_24v.xlsx'
if os.path.exists(csv_save_file_path):
    os.remove(csv_save_file_path)

save_mat = pd.DataFrame({'f/Hz': fs, 'P': Ps})
save_mat.to_excel(csv_save_file_path, index=False)

# Display plots
plt.tight_layout()
plt.show()
