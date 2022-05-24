#!/usr/bin/env python3

import os
import glob
import numpy as np
import pandas as pd
import sys

os.chdir(sys.argv[1])

df_all=pd.DataFrame(columns=['sample','type','count','mean','std','min','25%','50%','75%','max'])
i=1

#ls depth/120*depth
#depth/120.normal.depth  depth/120.tumor.depth

for fp in (glob.glob('depth/*.depth')):
    sample=fp.split('/')[1].split('.')[0]
    sample_type=fp.split('/')[1].split('.')[1]
#    print(sample_type)
    df=pd.DataFrame(pd.read_csv(fp,sep="\t",header=None))
    df.rename(columns={0:"chr",1:"pos",2:"depth"},inplace=True)
    s1=df.depth.describe()
    s2=pd.Series([sample,sample_type],index=["sample","type"])
#    print(s2)
    s3=s2.append(s1)
    print(s3)
    df_all.loc[i]=s3
    i=i+1

fo=open("allsamples_statistics.list",'w')
df_all.to_csv(fo,index=False,sep="\t")

