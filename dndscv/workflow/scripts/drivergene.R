## set up packages
options(repos = c(CRAN = "http://cran.rstudio.com"))
if (!requireNamespace("pak", quietly = TRUE))
  install.packages("pak")
if (!requireNamespace("dndscv", quietly = TRUE))
  pak::pkg_install("im3sanger/dndscv",ask = FALSE)

library("dndscv")

args <- commandArgs()
mutations <- read.csv(file = "output/drivergene.input",sep = "\t",header = FALSE,col.names = c("sampleID","chr","pos","ref","mut"))
mutations$chr = gsub("chr","",mutations$chr)
dndsout = dndscv(mutations,refdb = args[7] , cv=NULL)
sel_cv = dndsout$sel_cv
signif_genes = sel_cv[sel_cv$qglobal_cv<0.1, c("gene_name","qglobal_cv")]
write.csv(signif_genes,file = args[8])