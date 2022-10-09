#!/usr/bin/env bash
##download file according to the url of ./reference_mainfile.tsv
downloadFile() {
    local filename=$1
    local tool=$2
    local url=$3
    local filedir=$4
    local file=$filedir/$filename
    if [ ! -f $file ]; then
        if [ $tool != "-" ]; then
            if [ $tool == "wget" ]; then
                wget -N $url -P $filedir
                # echo "wget -N $url -P $filedir"
            elif [ $tool == "gsutil" ]; then
                gsutil cp -n -R $url $filedir
                # echo "gsutil cp -n -R $url $filedir"
            fi
        fi
    fi
}
export -f downloadFile
# downloadFile 1000G_omni2.5.hg38.vcf.gz gsutil gs://genomics-public-data/resources/broad/hg38/v0/1000G_omni2.5.hg38.vcf.gz
# parallel -j 10 downloadFile ::: $(cut -f 1 reference_mainfile.tsv) ::: $(cut -f 3 reference_mainfile.tsv) ::: $(cut -f 4 reference_mainfile.tsv)
parallel -j ${snakemake_resources} --colsep '\t' -a ${snakemake_params}/reference_mainfile.tsv downloadFile {1} {3} {4} ${snakemake_params} > "${snakemake_log[0]}" 2>&1
