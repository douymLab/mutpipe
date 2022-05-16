# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/octopus/octopus.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_octopus --file environment.yaml

Then you could activate the environment "mutpipe_octopus" through this command:
 
  > $ conda activate mutpipe_octopus

## Resource:
To run this pipeline, the below resources must exit under the "resources" folder:
- Reference genome (hg38): Homo_sapiens_assembly38.fasta.gz
- FASTA index file: Homo_sapiens_assembly38.fasta.fai
- octopus pre-traning model (More details: https://github.com/luntergroup/octopus)
    + somatic.v0.7.4.forest
    + germline.v0.7.4.forest
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
    > OR \$ sbatch pipe.sbatch.sh

## Demo
### input:
test bamfile we provide under the "demo" folder
### output:
> output_dir/filter/test.vcf.gz  

> chr1	14932	.	G	T	108.04	RF	AC=2;AN=4;DP=30;MQ=27;NS=2;PP=108.04;RFGQ_ALL=2.84	GT:GQ:DP:MQ:PS:PQ:FT:RFGQ	0|1:108:4:22:14932\:100\:RF:2.76	0|1:108:26:27:14932\:100\:RF:2.92  
> chr1	15903	.	G	GC	36.45	PASS	AC=4;AN=4;DP=3;MQ=28;NS=2;PP=36.45;RFGQ_ALL=6.92	GT:GQ:DP:MQ:PS:PQ:FT:RFGQ	1|1:8:1:35:15903\:100\:PASS:8.03	1|1:8:2:25:15903\:100\:PASS:6.07



