import argparse
import numpy as np
parser = argparse.ArgumentParser(description="generate seg config file for BIC-SEQ2")
parser.add_argument('-tumor_bin', type=str, default=None, help='tumor bin dir')
parser.add_argument('-normal_bin', type=str, default=None, help='normal bin dir')
parser.add_argument('-config', type=str, default=None, help='config file')

args = parser.parse_args()
tumor_bin_dir = args.tumor_bin
normal_bin_dir = args.normal_bin
config = args.config

config_file = open(config, 'w')
header = "chromName\tbinFileNorm.Case\tbinFileNorm.Control\n"
config_file.write(header)
chr_array = np.arange(1,23)
chrlist = chr_array.tolist()
print(chrlist,"chrlist")
chrlist.append('X')
chrlist.append('Y')
for chrom in chrlist:
    chrom = str(chrom)
    chr_field = "chr" + chrom
    tumor_bin_field = tumor_bin_dir + "chr" + chrom + ".norm.bin"
    normal_bin_field = normal_bin_dir + "chr" + chrom + ".norm.bin"
    line = "{}\t{}\t{}\n".format(chr_field, tumor_bin_field, normal_bin_field)
    config_file.write(line)
    #print(chrom)
config_file.close()
