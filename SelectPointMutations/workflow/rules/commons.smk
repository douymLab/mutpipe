configfile: "config/config.yaml"
import os
import socket

mutect2_path = config['vcf_links']['mutect2']
octopus_path = config['vcf_links']['octopus']
strelka2_path = config['vcf_links']['strelka2']

outPath=config['path']['output']

ANNOVAR=config['path']['ANNOVAR']
humandb=config['path']['humandb']