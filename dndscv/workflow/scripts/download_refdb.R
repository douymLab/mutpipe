log <- file(snakemake@log[[1]], open="wt")
sink(log)
if (!file.exists(snakemake@output[[1]])) {
  writeLines("fail", snakemake@output[[2]])
  download.file(url = 
                  paste0("https://raw.githubusercontent.com/im3sanger/dndscv_data/master/data/",
                         snakemake@params[[1]]),
                destfile = snakemake@output[[1]])
}
if (file.exists(snakemake@output[[1]])) {
  print("ok")
  writeLines("ok", snakemake@output[[2]])
}
