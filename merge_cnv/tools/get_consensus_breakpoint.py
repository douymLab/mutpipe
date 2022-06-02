import argparse
import numpy as np

parser = argparse.ArgumentParser(description="get consensus breakpoints")
parser.add_argument('-i', type=str, default=None, help='breakpoints in intersaction of intervals')
parser.add_argument('-o', type=str, default=None, help='representive breakpoints')
args = parser.parse_args()

in_file = args.i
out_file = args.o

out = open(out_file, 'w')
data = open(in_file, 'r')

for line in data:
    l = line.replace("\n","")
    lines = l.split(" ")
    lines = list(map(int, lines))
    print(lines)
    
    intersection_chr = lines[0]
    intersection_start = lines[1]
    intersection_end = lines[2]

    bicseq2_start = lines[4]
    bicseq2_end = lines[5]
    dnacopy_start = lines[8]
    dnacopy_end = lines[9]
    freec_start = lines[12]
    freec_end = lines[13]

    
    if bicseq2_start > intersection_start and bicseq2_start < intersection_end:
        bicseq2_start_status = bicseq2_start
    else:
        bicseq2_start_status = '_'
    print("bicseq2_start_status",bicseq2_start_status)

    if bicseq2_end > intersection_start and bicseq2_end < intersection_end:
        bicseq2_end_status = bicseq2_end
    else:
        bicseq2_end_status = '_'
    print("bicseq2_end_status:",bicseq2_end_status)

    if dnacopy_start > intersection_start and dnacopy_start < intersection_end:
        dnacopy_start_status = dnacopy_start
    else:
        dnacopy_start_status = '_'
    print("dnacopy_start_status",dnacopy_start_status)

    if dnacopy_end > intersection_start and dnacopy_end < intersection_end:
        dnacopy_end_status = dnacopy_end
    else:
        dnacopy_end_status = '_'
    print("dnacopy_end_status:",dnacopy_end_status)

    if freec_start > intersection_start and freec_start < intersection_end:
        freec_start_status = freec_start
    else:
        freec_start_status = '_'
    print("freec_start_status",freec_start_status)

    if freec_end > intersection_start and freec_end < intersection_end:
        freec_end_status = freec_end
    else:
        freec_end_status = '_'
    print("freec_end_status:",freec_end_status)
    
    bicseq2_gm = lines[6]
    dnacopy_gm = lines[10]
    freec_gm = lines[14]
    #gms = np.array([bicseq2_gm, dnacopy_gm, freec_gm])
    ##gms = gms.astype(np.int32)
    #print(gms)

    #ranks = gms.argsort()
    #print(ranks)
    #if ranks[0] == 0:
    #    print(bicseq2_gm)
    #elif ranks[0] == 1:
    #    print(dnacopy_gm)
    #else:
    #    print(freec_gm)

    
    if bicseq2_start_status != '_' and bicseq2_end_status != '_':
        bicseq2_bp = bicseq2_start_status
    elif bicseq2_start_status != '_' and bicseq2_end_status == '_':
        bicseq2_bp = bicseq2_start_status
    elif bicseq2_start_status == '_' and bicseq2_end_status != '_':
        bicseq2_bp = bicseq2_end_status
    else:
        bicseq2_bp = '_'
    if bicseq2_bp == '_':
        bicseq2_gm = '_'
    
    if dnacopy_start_status != '_' and dnacopy_end_status != '_':
        dnacopy_bp = dnacopy_start_status
    elif dnacopy_start_status != '_' and dnacopy_end_status == '_':
        dnacopy_bp = dnacopy_start_status
    elif dnacopy_start_status == '_' and dnacopy_end_status != '_':
        dnacopy_bp = dnacopy_end_status
    else:
        dnacopy_bp = '_'
    if dnacopy_bp == '_':
        dnacopy_gm = '_'

    if freec_start_status != '_' and freec_end_status != '_':
        freec_bp = freec_start_status
    elif freec_start_status != '_' and freec_end_status == '_':
        freec_bp = freec_start_status
    elif freec_start_status == '_' and freec_end_status != '_':
        freec_bp = freec_end_status
    else:
        freec_bp = '_'
    if freec_bp == '_':
        freec_gm = '_'

    if bicseq2_gm == '_': 
        bicseq2_gm = float("inf")
    if dnacopy_gm == '_':
        dnacopy_gm = float("inf")
    if freec_gm == '_':
        freec_gm = float("inf")
    
    if bicseq2_gm == '_' and dnacopy_gm == '_' and freec_gm == '_':
        bp = intersection_start
    else:
        gms = np.zeros(3)
        gms[0] = bicseq2_gm
        gms[1] = dnacopy_gm
        gms[2] = freec_gm
        sorted_key = np.argsort(gms)
        if sorted_key[0] == 0:
            bp = bicseq2_bp
        elif sorted_key[0] == 1:
            bp = dnacopy_bp
        else:
            bp = freec_bp

    print('{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n'.format(intersection_chr,intersection_start,intersection_end,bicseq2_bp,bicseq2_gm,dnacopy_bp,dnacopy_gm,freec_bp,freec_gm,bp))

    row = '{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\n'.format(intersection_chr,intersection_start,intersection_end,bicseq2_bp,bicseq2_gm,dnacopy_bp,dnacopy_gm,freec_bp,freec_gm,bp)
    out.write(row)

data.close()
out.close()
