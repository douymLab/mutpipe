import argparse
import numpy as np
parser = argparse.ArgumentParser(description="generate norm config file for BIC-SEQ2")
parser.add_argument('-ref', type=str, default=None, help='ref dir')
parser.add_argument('-kmer', type=str, default=None, help='kmer prefix')
parser.add_argument('-seq', type=str, default=None, help='seq dir')
parser.add_argument('-bin', type=str, default=None, help='bin dir')
parser.add_argument('-config', type=str, default=None, help='config file')

args = parser.parse_args()
ref = args.ref
kmer = args.kmer
seq = args.seq
bin_dir = args.bin
config = args.config

config_file = open(config, 'w')
header = "chromName\tfaFile\tMapFile\treadPosFile\tbinFileNorm\n"
config_file.write(header)
chr_array = np.arange(1,23)
chrlist = chr_array.tolist()
print(chrlist,"chrlist")
chrlist.append('X')
chrlist.append('Y')
for chrom in chrlist:
    chrom = str(chrom)
    chr_field = "chr" + chrom
    ref_field = ref + "chr" + chrom + ".fa"
    #kmer_field = kmer + "hg38.150mer.m2.chr"+ chrom+".txt"
    kmer_field = kmer + chrom+".txt"
    seq_field = seq + chrom + ".seq"
    bin_field = bin_dir + "chr" + chrom + ".norm.bin"
    line = "{}\t{}\t{}\t{}\t{}\n".format(chr_field, ref_field, kmer_field, seq_field, bin_field)
    config_file.write(line)
    #print(chrom)
config_file.close()
