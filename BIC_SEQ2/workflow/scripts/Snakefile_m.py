##GATK: v4.2.2.0
import socket
shell.prefix("module load gcc; module load jdk/11.0.10; source ~/.bashrc; source /storage/douyanmeiLab/wangchunyi/miniconda3/etc/profile.d/conda.sh; conda activate mutpipe_bicseq2; module load samtools/1.13; module load R/4.1.2")
sample_IDs, =glob_wildcards("/storage/douyanmeiLab/TCGA_wu/demo/{sample}.tumor.bam")
chr_list = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","X","Y"]

#sample_IDs = "YC-002"
# a pseudo-rule that collects the target files
rule all:
	input:
		expand("resources/genmap.log"),
		expand("resources/hg38.150mer.m2.chr{chr_index}.txt",chr_index=chr_list),
		expand("seq/tumor/{sample}/chr.seq", sample=sample_IDs),
		expand("seq/tumor/{sample}/seq.log", sample=sample_IDs),
		expand("seq/normal/{sample}/seq.log", sample=sample_IDs),
		expand("norm_config/tumor/{sample}.tumor.config", sample=sample_IDs),
		expand("norm_config/normal/{sample}.normal.config", sample=sample_IDs),
		expand("seg_config/{sample}.seg.config", sample=sample_IDs),
		expand("output/tumor/{sample}.output", sample=sample_IDs),
		expand("output/normal/{sample}.output", sample=sample_IDs),
		expand("results/{sample}_pvalue.CNVs", sample=sample_IDs),
		
#require big memory
rule genmap:
	input:
	output:
		#log="resources/genmap.log",
		bedgraph="resources/genmap.bedgraph"
	params:
		map_dir="resources/genmap",
		index_path="resources/grch38-no-alt"
	shell:
		"""
		genmap map -K 150 -E 2 -I {params.index_path} -O {params.map_dir} -t -w -bg
		"""
rule mappable_region:
	input:
		#log="resources/genmap.log",
		bedgraph="resources/genmap.bedgraph"
	output:
		out="resources/hg38.150mer.m2.chr{chr_index}.txt"
	params:
		chr="chr{chr_index}"
		#bedgraph="resources/genmap/grch38-no-alt.genmap.bedgraph"
	shell:
		"""
		awk '{{if ($1=="{params.chr}") print}}' {input.bedgraph}|awk '{{if($4==1) printf "%s\\t%s\\n",$2,$3}}'> {output.out}
		"""
rule tumor_seq:
	input:
		bam="/storage/douyanmeiLab/TCGA_wu/demo/{sample}.tumor.bam"	
	output:
		chr_seq="seq/tumor/{sample}/chr.seq"
	shell:
		"""
		samtools view {input.bam} |awk '{{print $3,$4}}'> {output.chr_seq}
		"""
rule tumor_chr_seq:
	input:
		chr_seq="seq/tumor/{sample}/chr.seq"
	output:
		out="seq/tumor/{sample}/seq.log"
	params:
		out_dir="seq/tumor/{sample}/"
	shell:
		"""
		python tools/split_chr_seq.py -seq {input.chr_seq} -outdir {params.out_dir} > {output.out}
		"""
rule normal_seq:
	input:
		bam="/storage/douyanmeiLab/TCGA_wu/demo/{sample}.normal.bam"	
	output:
		chr_seq="seq/normal/{sample}/chr.seq"
	shell:
		"""
		samtools view {input.bam} |awk '{{print $3,$4}}'> {output.chr_seq}
		"""
rule normal_chr_seq:
	input:
		chr_seq="seq/normal/{sample}/chr.seq"
	output:
		out="seq/normal/{sample}/seq.log"
	params:
		out_dir="seq/normal/{sample}/"
	shell:
		"""
		python tools/split_chr_seq.py -seq {input.chr_seq} -outdir {params.out_dir} > {output.out}
		"""
rule gen_tumor_norm_config:
	input:
		seq="seq/tumor/{sample}/seq.log",
	output:
		config="norm_config/tumor/{sample}.tumor.config",
	params:
		ref="resources/ref/",
		kmer="resources/hg38.150mer.m2.chr",
		seq="seq/tumor/{sample}/",
		bin="bin/tumor/{sample}/",
	shell:
		"""
		python tools/gen_norm_config.py -ref {params.ref} -kmer {params.kmer} -seq {params.seq} -bin {params.bin} -config {output.config}
		"""
rule gen_normal_norm_config:
	input:
		seq="seq/normal/{sample}/seq.log",
	output:
		config="norm_config/normal/{sample}.normal.config",
	params:
		ref="resources/ref/",
		kmer="resources/hg38.150mer.m2.chr",
		seq="seq/normal/{sample}/",
		bin="bin/normal/{sample}/",
	shell:
		"""
		python tools/gen_norm_config.py -ref {params.ref} -kmer {params.kmer} -seq {params.seq} -bin {params.bin} -config {output.config}
		"""
rule gen_seg_config:
	input:
		normal_config="norm_config/normal/{sample}.normal.config",
		tumor_config="norm_config/tumor/{sample}.tumor.config",
	output:
		config="seg_config/{sample}.seg.config"
	params:
		tumor_bin="bin/tumor/{sample}/",
		normal_bin="bin/normal/{sample}/",
	shell:
		"""
		python tools/gen_seg_config.py -tumor_bin {params.tumor_bin} -normal_bin {params.normal_bin} -config {output.config}
		"""
rule norm_tumor:
	input: 
		conf="norm_config/tumor/{sample}.tumor.config",
	output:
		out="output/tumor/{sample}.output",
		bin="bin/tumor/{sample}/chr16.norm.bin"
	shell:
		"""
		perl tools/NBICseq-norm_v0.2.4/NBICseq-norm.pl {input.conf} {output.out}
		"""
rule norm_normal:
	input: 
		conf="norm_config/normal/{sample}.normal.config",
	output:
		out="output/normal/{sample}.output",
		bin="bin/normal/{sample}/chr16.norm.bin"
	shell:
		"""
		perl tools/NBICseq-norm_v0.2.4/NBICseq-norm.pl {input.conf} {output.out}
		"""
rule seg_p_value:
	input:
		tumor_out="output/tumor/{sample}.output",
		normal_out="output/normal/{sample}.output",
		conf="seg_config/{sample}.seg.config"
	output:
		out="results/{sample}_pvalue.CNVs",
		png="results/{sample}.pvalue.cnv.profile.png"
	params:
		title="{sample}_pvalue_CNV_profile"
	shell:
		"""
		perl tools/NBICseq-seg_v0.7.2/NBICseq-seg.pl --control {input.conf} {output.out} --fig {output.png} --title {params.title} --bootstrap
		"""