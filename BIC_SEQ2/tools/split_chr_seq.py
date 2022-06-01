import argparse
import numpy as np
import math
from collections import defaultdict, namedtuple

parser = argparse.ArgumentParser(description="split reference chromosome")
parser.add_argument('-seq', type=str, default=None, help='seq file for all chr')
parser.add_argument('-outdir', type=str, default=None, help='output dir')

args = parser.parse_args()

seq = args.seq
outdir = args.outdir

seq_handler = open(seq, 'r')
for line in seq_handler:
    fields = line.strip().split(' ')
    chrom, pos = fields[0], fields[1]
    if chrom.startswith('chr'):
        chrom_num = chrom[3:]
    else:
        chrom_num = chrom
    out = open(outdir + chrom_num + ".seq", 'a+')
    out.write(pos+"\n")
seq_handler.close()

