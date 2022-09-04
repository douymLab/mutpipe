configfile: "config/config.yaml"
import os

refdb_dir = config['path']['refdb_dir']
refdb_file = config['path']['refdb_file']
refdb_path = os.path.join(refdb_dir,refdb_file)

inputPath = config['path']['input']
outPath = config['path']['out']
