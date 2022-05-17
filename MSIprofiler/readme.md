# Quick Start 
![avatar](https://github.com/douymLab/mutpipe/blob/main/MSIprofiler/MSIprofiler.png)
## Dependency:  

we strongly suggest installing dependencies via conda:

  > $ conda create -n mutpipe_MSIprofiler --file environment.yaml

Then you could activate the environment "mutpipe_MSIprofiler" through this command:
 
  > $ conda activate mutpipe_MSIprofiler

### Install MSIprofiler
MSIprofier not includ in conda package, please install MSIprofier manually.
To insall MSIprofier(https://github.com/parklab/MSIprofiler):
  > $ git clone https://github.com/parklab/MSIprofiler.git && cd MSIprofiler  

Then download the fasta sequences for the chromosomes (hg38) and generate the reference set of MS repeats:   
1. **first edit the download scripts** 
    > path/to/MSIprofiler/scripts/download_chromosomes_fa.sh  

    change the command below
    > echo "Download fasta files for chrs (hg19)"  
    > wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr${i}.fa.gz

    as
    > echo "Download fasta files for chrs (hg38)"  
    > wget http://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/chr${i}.fa.gz 
2. run the command below (workpath is the path to MSIprofiler)
    > \$ ./scripts/download_chromosomes_fa.sh  
    > \$ python scripts/get_reference_set_from_fasta.py  
    > \$ ./scripts/sort_reference_sets.sh  
3. Make sure to add the current directory to your PYTHONPATH: export PYTHONPATH=$PYTHONPATH:$PWD

## Run on slurm

1. Change all directory names in the "Snakefile".
2. dry run test
    > snakemake -np
3. actual run
    > \$ source {your_dir}/miniconda3/etc/profile.d/conda.sh  
    > \$ conda activate gatk4  
    > \$ snakemake --unlock snakemake --rerun-incomplete -j {job_num} --latency-wait 120 --cluster-config slurm.json --cluster "sbatch -p {queue} -c 1 -t 12:00:00 --mem=5000 -o logs/%j.out -e logs/%j.err "

## Select the confidence MSIprofiler result
To select the confidence MSIprofiler result, we use the following strategies:
1. Kolmogorov-Smirnov P value < 0.01  
2. The length of the MS repeat in the normal/control sample only 2 haplotype(eg. a site with length 7,7,7,6 is a MSIsite, while a site with 7,6,5,7 might be filtered)  
You can filter the MSI result use this command:
> \$ bash filter.sh path/to/input path/to/output  

eg.  
> \$ bash filter.sh demo/MSI/test.unphased.txt demo/MSI/test.unphased.filtered.txt

## Demo
### input:
test bamfile we provide under the "demo" folder
### output:
> output_dir/MSI/test.unphased.txt 

> chr9	97994572	97994579	TTGTTGTT	3	8	0.4	8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8	8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8	1.0 high    
chr9	97994610	97994615	TTTTTT	1	6	0.4	7,7,6,6,6,7,6,7,7,6,6,6,6,7,6,6,7,7,7,6,7,7,6,7,7,7,7,7	6,6,6,6,7,7,6,6,6,6,6,6,6,6,6,6,6,7,6,6,6,6,6,7,6,6,6,6,6,6,6,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7,7,7,7	0.00273445761255	low  
chr9	97994657	97994666	CAAATCAAAT	5	10	0.4	10,10,10,10,10,10,10,10,10,10,10,10	10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10	1.0	high

> output_dir/MSI/test.unphased.filterd.txt 
 
> chr9	97994610	97994615	TTTTTT	1	6	0.4	7,7,6,6,6,7,6,7,7,6,6,6,6,7,6,6,7,7,7,6,7,7,6,7,7,7,7,7	6,6,6,6,7,7,6,6,6,6,6,6,6,6,6,6,6,7,6,6,6,6,6,7,6,6,6,6,6,6,6,7,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7,7,7,7	0.00273445761255	low

