configfile: "config/config.yaml"
import os
import socket
res_dir = config['path']['ref_dir']
gz_ref_dir = config['path']['gz_ref_dir']

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']

fa_gz = config['gz_ref']['fa']

fa = config['ref']['fa']
fai = config['ref']['fai']
dict = config['ref']['dict']
bed= config['ref']['bed']
common_vcf = config['ref']['common_vcf']
common_vcfi = config['ref']['common_vcfi']