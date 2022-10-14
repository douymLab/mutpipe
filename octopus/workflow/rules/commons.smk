configfile: "config/config.yaml"
from concurrent.futures import thread
import os
import socket

threads = config['octopus_param']['threads']

ref_dir = config['path']['ref_dir']
gz_ref_dir = config['path']['gz_ref_dir']

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']

fa_gz = config['gz_ref']['fa']
interval_list_gz = config['gz_ref']['interval_list']
germline_gz = config['gz_ref']['germline']
somatic_gz = config['gz_ref']['somatic']

fa = config['ref']['fa']
fai = config['ref']['fai']
dict = config['ref']['dict']
interval_list = config['ref']['interval_list']
germline = config['ref']['germline']
somatic = config['ref']['somatic']