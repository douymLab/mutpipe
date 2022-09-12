configfile: "config/config.yaml"
import os
import socket

res_dir = config['path']['resources']

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']