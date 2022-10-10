import argparse
import numpy as np
from collections import defaultdict, namedtuple

parser = argparse.ArgumentParser(description="handle freec file")
parser.add_argument('-freec', type=str, default=None, help='freec copy number profile')
parser.add_argument('-chrlen', type=str, default=None, help='chr length')
parser.add_argument('-o', type=str, default=None, help='out file')

args = parser.parse_args()

freec = args.freec
chrlen = args.chrlen
out = args.o

chrlen_dict = defaultdict(list)

chrlen_file = open(chrlen, 'r')
for line in chrlen_file:
    fields = line.strip().split()
    chrom, chr_len = fields[0], int(fields[1])
    chrlen_dict[chrom].append(0)
    chrlen_dict[chrom].append(chr_len)
chrlen_file.close()

interval_dict = defaultdict(list)

freec_file = open(freec, 'r')
for line in freec_file:
    fields = line.strip().split()
    chrom, start, end = fields[0], int(fields[1]), int(fields[2])
    if (chrlen_dict[chrom][1] - end == 1):
        interval_dict[chrom].append((start,chrlen_dict[chrom][1]))
    else:
        interval_dict[chrom].append((start, end))

freec_file.close()


out_file = open(out,'w')
for chrom in interval_dict.keys():
    #print(chrom, interval_dict[chrom])
    for interval in interval_dict[chrom]:
        line = "{}\t{}\t{}\n".format(chrom, interval[0],interval[1])
        print(line)
        out_file.write(line)

out_file.close()
