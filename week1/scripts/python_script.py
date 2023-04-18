#!/usr/bin python3

import pandas as pd
import glob
import os

input_path = '/home/alator20/wcd-assignments/week1/input'
output_path = '/home/alator20/wcd-assignments/week1/output'
filename = 'all_years.csv'
csvs = glob.glob(os.path.join(input_path , "*.csv"))


df_concat = pd.DataFrame()

for f in csvs:
    df = pd.read_csv(f, index_col=None, header=0)
    #li.append(df)
    df_concat= pd.concat([df_concat,df],axis=0, ignore_index=True)

df_concat.to_csv(output_path+"/"+filename)