file_lists = readLines("https://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/")
file_pattern <- "(?<=\\>).*?(?>\\.gz|\\.txt)"
m = regexpr(file_pattern,file_lists,perl = TRUE)
res <- regmatches(file_lists,m)
res2 <- paste0("https://hgdownload.cse.ucsc.edu/goldenPath/hg38/chromosomes/",res)
writeLines(res2,snakemake@output[[1]])