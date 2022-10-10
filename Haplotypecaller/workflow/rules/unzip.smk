## unzip reference genome (hg38) via GATK
rule decom_hs38:
	input: 
		fa = os.path.join(gz_ref_dir,fa_gz),
		fai = os.path.join(gz_ref_dir,fai),
		dict = os.path.join(gz_ref_dir,dict),
	output:
		fa = os.path.join(res_dir,fa),
		fai = os.path.join(res_dir,fai),
		dict = os.path.join(res_dir,dict),
	shell:
		"""
		zcat {input.fa} > {output.fa};
		cp {input.fai} {output.fai};
		cp {input.dict} {output.dict};
		"""

## unzip the WES interval file
rule decom_interval_file:
	input: os.path.join(gz_ref_dir,interval_list_gz),
	output:
		os.path.join(res_dir,interval_list),
	shell:
		"""
		zcat {input} > {output}
		"""