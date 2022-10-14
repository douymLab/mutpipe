configfile: "config/config.yaml"
import os
import socket
from tempfile import tempdir

TEMPDIR = config['TEMPDIR']

index_dir = config['path']['index_dir']
index_file = config['path']['index_file']
index_path = os.path.join(index_dir,index_file)

tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

outPath = config['path']['output']