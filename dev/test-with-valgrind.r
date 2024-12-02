library(readpdf)
file <- system.file("examples", "bondargentina.pdf", package = "readpdf")
d <- pdf_to_png(file)