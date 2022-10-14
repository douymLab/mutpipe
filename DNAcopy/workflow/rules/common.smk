configfile: "config/config.yaml"
import os
import socket

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']