import argparse
import os
import re
parser = argparse.ArgumentParser(description="generate bam config file")
parser.add_argument('--tumor', type=str, default=None, help='tumor bam')
parser.add_argument('--tumor_insert_size', type=str, default=None, help='tumor insert size')
parser.add_argument('--normal', type=str, default=None, help='normal bam')
parser.add_argument('--normal_insert_size', type=str, default=None, help='normal insert size')
parser.add_argument('--sample', type=str, default=None, help='sample_id')
parser.add_argument('-o', type=str, default=None, help='output bam config file')
args = parser.parse_args()
#print(args.normal)
#print(args.tumor)
normal = args.normal
normal_is = args.normal_insert_size
tumor = args.tumor
tumor_is = args.tumor_insert_size
sample = args.sample
output = args.o
print(normal)
print(tumor)
print(sample)
print(output)

outfile = open(output, 'w')

tis = open(tumor_is)
tumor_line = tis.readline()
tumor_line = tumor_line.replace("\n","")
tumor_lines = tumor_line.split("\t")
tumor_insert_size = tumor_lines[2]
tis.close()

tumor_label = sample + "_tumor"
outfile.write(tumor + "\t" + tumor_insert_size + "\t" + tumor_label + "\r\n")

nis = open(normal_is)
normal_line = nis.readline()
normal_line = normal_line.replace("\n","")
normal_lines = normal_line.split("\t")
normal_insert_size = normal_lines[2]
nis.close()

normal_label = sample + "_normal"
outfile.write(normal + "\t" + normal_insert_size + "\t" + normal_label + "\r\n")

outfile.close()
