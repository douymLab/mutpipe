import argparse
import numpy as np
import math
from collections import defaultdict, namedtuple

parser = argparse.ArgumentParser(description="make consensus breakpoints")
parser.add_argument('-bp', type=str, default=None, help='intersection.bicseq2.dnacopy.freec.bp.bed')
parser.add_argument('-out', type=str, default=None, help='out')

args = parser.parse_args()

bp = args.bp
out = args.out

class Position(object):
  # Position was originally a namedtuple, but we want it to be mutable.
  def __init__(self, chrom, pos, postype, method):
    self.chrom = chrom
    self.pos = pos
    self.postype = postype
    self.method = method

  def __str__(self):
    return '%s, %s, %s, %s' % (self.chrom, self.pos, self.postype, self.method)

  def __repr__(self):
    return str(self)

bpf = open(bp, 'r')
outf = open(out, 'w')
for line in bpf:
    fields = line.strip().split(' ')
    chrom, start, end, bic_chrom, bic_start, bic_end, dna_chrom, dna_start, dna_end, freec_chrom, freec_start, freec_end = fields[0], int(fields[1]), int(fields[2]), fields[3], int(fields[4]), int(fields[5]), fields[6], int(fields[7]), int(fields[8]), fields[9], int(fields[10]), int(fields[11])
    bp_scores = {}
    #for bp in (bic_start, bic_end):
    #    if bp >= start and bp <= end:
    #        bp_scores[bp] = bic_end - bic_start
    #for bp in (dna_start, dna_end):
    #    if bp >= start and bp <= end:
    #        bp_scores[bp] = dna_end - dna_start
    #for bp in (freec_start, freec_end):
    #    if bp >= start and bp <= end:
    #        bp_scores[bp] = freec_end - freec_start
    if bic_chrom != '.':
        if bic_start >= start and bic_start <= end:
            bp_start = Position(chrom, bic_start, "start", "bic_seq2")
            bp_scores[bp_start] = bic_end - bic_start
        elif bic_end >= start and bic_end <= end:
            bp_end = Position(chrom, bic_end, "end", "bic_seq2")
            bp_scores[bp_end] = bic_end - bic_start

    if dna_chrom != '.':
        if dna_start >= start and dna_start <= end:
            bp_start = Position(chrom, dna_start, "start", "dnacopy")
            bp_scores[bp_start] = dna_end - dna_start
        elif dna_end >= start and dna_end <= end:
            bp_end = Position(chrom, dna_end, "end", "dnacopy")
            bp_scores[bp_end] = dna_end - dna_start

    if freec_chrom != '.':
        if freec_start >= start and freec_start <= end:
            bp_start = Position(chrom, freec_start, "start", "freec")
            bp_scores[bp_start] = freec_end - freec_start
        elif freec_end >= start and freec_end <= end:
            bp_end = Position(chrom, freec_end, "end", "freec")
            bp_scores[bp_end] = freec_end - freec_start
    if len(bp_scores) == 0:
        bp_start = Position(chrom, start, "undirected", "no_bp_in_intersection")
        bp_scores[bp_start] = 1
    sorted_ = sorted(bp_scores.items(), key = lambda y:y[1])
    print("sorted:",sorted_, sorted_[0][0].pos)
    #new_line = "{} {}\n".format(line.strip(),sorted_[0][0].pos)
    new_line = "{}\t{}\t{}\t{}\n".format(chrom, start, end, sorted_[0][0].pos)
    print(new_line)
    outf.write(new_line)
bpf.close()
outf.close()
