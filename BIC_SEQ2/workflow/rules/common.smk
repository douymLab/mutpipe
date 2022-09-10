configfile: "config/config.yaml"
import os
import socket

TEMPDIR = config['TEMPDIR']

res_dir = config['path']['res_dir']

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']

chr_list = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X","Y"]
