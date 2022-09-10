# Define rules to be run locally when using a compute cluster
from tabnanny import check


localrules:
	index_chr_files,
	download_chr_files,
	download_map_index,

aria2c_threads = config['aria2c_threads']

fasta_dir = os.path.join(res_dir,"fasta/")

rule index_chr_files:
	output:
		file_links = os.path.join(fasta_dir,"file_links.txt"),
	conda: "aria2",
	script:
		"../scripts/chr_files.R"

gz_files = expand(os.path.join(fasta_dir,"chr{chr_list}.fa.gz"),chr_list=chr_list)
rule download_chr_files:
	input: 
		file_links = ancient(os.path.join(fasta_dir,"file_links.txt")),
	log: os.path.join(fasta_dir,"_downloaded_chr_files.log"),
	conda: "aria2",
	shell:
		"""
		aria2c -c -s {aria2c_threads} -x {aria2c_threads} -k 1M -j 2 --file-allocation=none -i {input.file_links} -d {fasta_dir} > {log} && yes no | gunzip -k {gz_files}
		"""

fas_files = expand(os.path.join(fasta_dir,"chr{chr_list}.fa"),chr_list=chr_list)
rule check_chr_files:
	input: ancient(os.path.join(fasta_dir,"_downloaded_chr_files.log")),
	output:os.path.join(fasta_dir,"{type}/{sample}/check_chr_files.log"),
	conda: "aria2",
	shell:
		"""
		for i in fas_files; do test -f "$i" && echo "$i exists."; done; >> {output}
		"""



rule download_map_index:
	output:
		map_gz = os.path.join(res_dir,"grch38-no-alt.tar.gz"),
	conda: "aria2",
	shell:
		"aria2c -c -s {aria2c_threads} -x {aria2c_threads} -k 1M -j 2 --file-allocation=none -d {res_dir} -o {output.map_gz} http://ftp.imp.fu-berlin.de/pub/cpockrandt/genmap/indices/grch38-no-alt.tar.gz"

rule decom_map_index:
	input:
		map_gz = os.path.join(res_dir,"grch38-no-alt.tar.gz"),
	output:
		directory(os.path.join(res_dir,"grch38-no-alt")),
	conda: "aria2",
	shell:
		"tar --use-compress-program=pigz -xvpf {input.map_gz} -C {res_dir}"