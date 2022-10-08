configfile: "config/config.yaml"
import os

refdb_dir = config['path']['ref_dir']
refdb_file = config['path']['ref_file']
refdb_path = os.path.join(refdb_dir,refdb_file)

inputPath = config['path']['input']
outPath = config['path']['output']
