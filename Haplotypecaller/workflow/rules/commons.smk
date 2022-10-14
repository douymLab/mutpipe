configfile: "config/config.yaml"
import os
import socket

res_dir = config['path']['ref_dir']
gz_ref_dir = config['path']['gz_ref_dir']

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']

fa_gz = config['gz_ref']['fa']
interval_list_gz = config['gz_ref']['interval_list']

fa = config['ref']['fa']
fai = config['ref']['fai']
dict = config['ref']['dict']
interval_list = config['ref']['interval_list']
snp= config['ref']['snp']
snpi= config['ref']['snpi']
poly= config['ref']['poly']
polyi= config['ref']['polyi']
hapmap= config['ref']['hapmap']
hapmapi= config['ref']['hapmapi']
omn= config['ref']['omn']
omni= config['ref']['omni']
highsnp= config['ref']['highsnp']
highsnpi= config['ref']['highsnpi']
mills= config['ref']['mills']
millsi= config['ref']['millsi']

maxGaussians = config['max-gaussians']