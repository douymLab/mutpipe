import argparse
import configparser
parser = argparse.ArgumentParser(description="generate config for freec")
#config = configparser.ConfigParser()
config= configparser.RawConfigParser()
config.optionxform = lambda option: option

parser.add_argument('-fai', type=str, default=None, help='chrLenFile')
parser.add_argument('-tumor', type=str, default=None, help='tumor bam')
parser.add_argument('-normal', type=str, default=None, help='normal bam')
parser.add_argument('-dir', type=str, default=None, help='output dir')
parser.add_argument('-config',type=str, default=None, help='config file name')
parser.add_argument('-coefficientOfVariation',type=str, default=None, help='coefficientOfVariation')
parser.add_argument('-numThreads',type=str, default=None, help='numThreads')

args = parser.parse_args()

fai = args.fai
tumor = args.tumor
normal = args.normal
outputdir = args.dir
config_control = args.config
coefficientOfVariation = args.coefficientOfVariation
numThreads = args.numThreads

config["general"]={}
config["general"]["chrLenFile"] = fai
config["general"]["coefficientOfVariation"] = coefficientOfVariation
config["general"]["ploidy"] = "2"
config["general"]["outputDir"] = outputdir
config["general"]["maxThreads"] = numThreads

config["sample"]={}
config["sample"]["mateFile"]=tumor
config["sample"]["inputFormat"]="bam"
config["sample"]["mateOrientation"]="FR"

config["control"]={}
config["control"]["mateFile"]=normal
config["control"]["inputFormat"]="bam"
config["control"]["mateOrientation"]="FR"


with open(config_control, "w") as f:
    config.write(f)

