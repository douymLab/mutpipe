cd ${snakemake_params}
get_ref_func() {
	local chr_list=$1
	if [ ! -f reference_set_$chr_list.txt ]; then
		echo "get reference set for $chr_list"
		python scripts/get_reference_set_from_fasta.py --notation UCSC --chr $chr_list
		echo "reference set for $chr_list readyed"
	else
		echo "reference set for $chr_list readyed"
	fi
	mkdir -p reference_sets;
	if [ ! -f reference_set_${chr_list}_sorted.txt ]; then
		echo "sort reference set for $chr_list"
		sort -k 2 reference_set_${chr_list}.txt > reference_sets/reference_set_${chr_list}_sorted.txt
		echo "reference set for $chr_list sorted"
	else
		echo "reference set for $chr_list sorted"
	fi
}
export -f get_ref_func
parallel -j ${snakemake_resources} get_ref_func ::: ${snakemake_wildcards[chr_list]}