## set up packages
options(repos = c(CRAN = "http://cran.rstudio.com"))
if (!requireNamespace("pak", quietly = TRUE))
  install.packages("pak")
if (!requireNamespace("dndscv", quietly = TRUE))
  pak::pkg_install("im3sanger/dndscv",ask = FALSE)