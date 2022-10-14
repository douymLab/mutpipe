configfile: "config/config.yaml"
import os
import socket

TEMPDIR = config['TEMPDIR']

res_dir = config['path']['res_dir']
ref_gz_dir = config['path']['ref_gz_dir']

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']

nbicseq_seg = config['path']['nbicseq_seg']
nbicseq_norm = config['path']['nbicseq_norm']

chr_list = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X","Y"]

fas_gz_files = expand(os.path.join(ref_gz_dir,"chr{chr_list}.fa.gz"),chr_list=chr_list)
fas_gz_files2 = expand(os.path.join(res_dir,"chr{chr_list}.fa.gz"),chr_list=chr_list)
fas_files = expand(os.path.join(res_dir,"chr{chr_list}.fa"),chr_list=chr_list)