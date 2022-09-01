#!/bin/sh
mkdir -p resources;
cd resources;

## Downloading RefCDS objects to run dndscv
wget -N https://github.com/im3sanger/dndscv_data/blob/master/data/RefCDS_human_GRCh38_GencodeV18_recommended.rda