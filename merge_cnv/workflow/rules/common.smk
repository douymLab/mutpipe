configfile: "config/config.yaml"
import os
import resource
import socket

annovar_path = os.path.abspath(config['path']['ANNOVAR'])
humandb_path = os.path.abspath(config['path']['humandb'])

outPath = os.path.abspath(config['path']['output'])

gz_ref_dir = os.path.abspath(config['path']['gz_ref_dir'])

ref_dir = os.path.abspath(config['path']['ref_dir'])

fa_gz = config['gz_ref']['fa']

fa = config['ref']['fa']
fai = config['ref']['fai']
dict = config['ref']['dict']
centromeric = config['ref']['centromeric']
telomere = config['ref']['telomere']
hg38_len = config['ref']['hg38_len']
hg38_len_offset = config['ref']['hg38_len_offset']

bic_seq2_res = os.path.abspath(config['pre_res']['bic_seq2_res'])
dnacopy_res = os.path.abspath(config['pre_res']['dnacopy_res'])
freec_res = os.path.abspath(config['pre_res']['freec_res'])