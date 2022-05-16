# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/strelka2/strelka2.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_strelka --file environment.yaml

Then you could activate the environment "mutpipe_strelka" through this command:
 
  > $ conda activate mutpipe_strelka

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Reference genome (hg38): Homo_sapiens_assembly38.fasta.gz
- FASTA index file: Homo_sapiens_assembly38.fasta.fai
- WES interval list: S31285117_Padded.list.gz
Note: The interval list is based on our WES kit is Sureselect Human All Exon V7. The list and other version kit's list can download form https://earray.chem.agilent.com/suredesign/

The required resource could be downloaded through running:

> $bash download.sh

 Or you also can soft-link the file into the "resources" folder.

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate gatk4  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

## Demo
### input:
test bamfile we provide under the "demo" folder
### output:
> output_dir/results/variants/somatic.snvs.vcf.gz  

> chr1	1045481	.	A	C	.	LowEVS	SOMATIC;QSS=1;TQSS=1;NT=ref;QSS_NT=1;TQSS_NT=1;SGT=AA->AA;DP=71;MQ=60.00;MQ0=0;ReadPosRankSum=-1.61;SNVSB=0.00;SomaticEVS=0.40	DP:FDP:SDP:SUBDP:AU:CU:GU:TU	10:0:0:0:10,10:0,0:0,0:0,0	60:0:0:0:58,59:2,2:0,0:0,0  
> chr1	1045564	.	C	A	.	PASS	SOMATIC;QSS=54;TQSS=1;NT=ref;QSS_NT=54;TQSS_NT=1;SGT=CC->AC;DP=101;MQ=60.00;MQ0=0;ReadPosRankSum=0.34;SNVSB=0.00;SomaticEVS=8.50	DP:FDP:SDP:SUBDP:AU:CU:GU:TU	16:0:0:0:0,0:16,16:0,0:0,0	84:0:0:0:5,5:79,80:0,0:0,0  
> chr1	7745084	.	G	T	.	LowEVS	SOMATIC;QSS=19;TQSS=1;NT=ref;QSS_NT=19;TQSS_NT=1;SGT=GG->GT;DP=57;MQ=60.00;MQ0=0;ReadPosRankSum=1.80;SNVSB=0.00;SomaticEVS=1.18	DP:FDP:SDP:SUBDP:AU:CU:GU:TU	11:0:0:0:0,0:0,0:11,11:0,0	46:0:0:0:0,0:0,0:43,43:3,3


> output_dir/results/variants/somatic.snvs.vcf.gz 

> chr1	7745037	.	G	GGCT	.	PASS	SOMATIC;QSI=44;TQSI=1;NT=ref;QSI_NT=44;TQSI_NT=1;SGT=ref->het;MQ=60.00;MQ0=0;RU=GCT;RC=0;IC=1;IHP=4;SomaticEVS=8.01	DP:DP2:TAR:TIR:TOR:DP50:FDP50:SUBDP50:BCN50	31:31:31,31:0,0:0,0:24.99:0.00:0.00:0.00	84:84:77,77:6,6:1,1:69.41:0.46:0.00:0.00



