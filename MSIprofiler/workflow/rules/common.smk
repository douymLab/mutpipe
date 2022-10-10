msiprofiler = config['path']['msiprofiler']
ref_dir = config['path']['ref_dir']
gz_ref_dir = config['path']['gz_ref_dir']

outPath=config['path']['output']
tumor_path = config['path']['bam_tumor']
normal_path = config['path']['bam_normal']

min_coverage = config['parameters']['min_coverage']
nprocs=config['parameters']['nprocs']

get_ref_threads = config['threads']['get_ref']
msi_threads = config['threads']['msi']


chr_list = config['chr_list']

fas_dir = os.path.join(msiprofiler,"chrs_fa")
fas_dir = os.path.abspath(fas_dir)
fas_gz_files = expand(os.path.join(gz_ref_dir,"chr{chr_list}.fa.gz"),chr_list=chr_list)
fas_files = expand(os.path.join(fas_dir,"chr{chr_list}.fa"),chr_list=chr_list)