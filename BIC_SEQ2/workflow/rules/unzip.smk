rule decomp_chrs:
	input: fas_gz_files
	output: os.path.join(res_dir,"{types}/{sample}/check_chr_files.log")
	shell:
		"""
		cp -r -n {input} {res_dir}
        for i in {fas_files}; do

            if [ ! -f $i ]; then
                gunzip $i.gz;
            fi
            
        done;
		for i in {fas_files}; do test -f "$i" && echo "$i exists."; done; >> {output}
		"""

rule decom_map_index:
	input:
		map_gz = os.path.join(ref_gz_dir,"grch38-no-alt.tar.gz"),
	output:
		directory(os.path.join(res_dir,"grch38-no-alt")),
	log: os.path.join(res_dir,"grch38-no-alt_decomed.log")
	params: os.path.join(res_dir,"grch38-no-alt.tar.gz")
	conda: "mutpipe_bicseq",
	threads: 16
	shell:
		"""
		cp {input.map_gz} {params}
		tar --use-compress-program=pigz -xvpf {params} -C {res_dir}>{log}
		"""