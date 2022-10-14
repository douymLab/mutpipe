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

## unzip gff resources:
rule decom_gff:
	input: os.path.join(gz_ref_dir,gff_gz),
	output: os.path.join(ref_dir,gff),
	params: os.path.join(ref_dir,gff_gz),
	shell:
		"""
		cp {input} {params};
		gzip -d {params};
		"""

## unzip rep lib
rule decomreplib:
	input: os.path.join(gz_ref_dir,rep_lib_gz),
	output: directory(os.path.join(ref_dir,rep_lib)),
	params: os.path.join(ref_dir,rep_lib_gz),
	shell:
		"""
		cp {input} {params};
		mkdir -p {output};
		tar -zxvf {params} -C {output};
		"""