## unzip reference genome (hg38) via GATK
rule decom_hs38:
	input: 
		fa = os.path.join(gz_ref_dir,fa_gz),
		fai = os.path.join(gz_ref_dir,fai),
		dict = os.path.join(gz_ref_dir,dict),
	output:
		fa = os.path.join(ref_dir,fa),
		fai = os.path.join(ref_dir,fai),
		dict = os.path.join(ref_dir,dict),
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
		os.path.join(ref_dir,interval_list),
	shell:
		"""
		zcat {input} > {output}
		"""

## unzip forest resources:
rule decom_forest:
	input: 
		germline = os.path.join(gz_ref_dir,germline_gz),
		somatic = os.path.join(gz_ref_dir,somatic_gz),
	output: 
		germline = os.path.join(ref_dir,germline),
		somatic = os.path.join(ref_dir,somatic),
	params:
		germline_gz = os.path.join(ref_dir,germline_gz),
		somatic_gz = os.path.join(ref_dir,somatic_gz),
	shell:
		"""
		cp {input.germline} {params.germline_gz};
		cp {input.somatic} {params.somatic_gz};
		gzip -d {params.germline_gz};
		gzip -d {params.somatic_gz};
		"""