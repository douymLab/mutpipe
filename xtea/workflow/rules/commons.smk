configfile: "config/config.yaml"

import os
import socket

ref_dir = os.path.abspath(config['path']['ref_dir'])
gz_ref_dir = os.path.abspath(config['path']['gz_ref_dir'])

tumor_path = os.path.abspath(config['path']['bam_tumor'])
normal_path = os.path.abspath(config['path']['bam_normal'])

outPath = os.path.abspath(config['path']['output'])

xtea = os.path.abspath(config['path']['xtea'])

fa_gz = config['gz_ref']['fa']
gff_gz = config['gz_ref']['gff']
rep_lib_gz = config['gz_ref']['rep_lib']

fa = config['ref']['fa']
fai = config['ref']['fai']
dict = config['ref']['dict']
gff = config['ref']['gff']
rep_lib = config['ref']['rep_lib_dir']