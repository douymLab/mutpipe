configfile: "config/config.yaml"
import os

refdb_dir = config['path']['refdb_dir']
refdb_file = "RefCDS_human_GRCh38_GencodeV18_recommended.rda"
refdb_path = os.path.join(refdb_dir,refdb_file)