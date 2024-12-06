library(cpp11tesseract)
file <- system.file("examples", "bondargentina.pdf", package = "cpp11tesseract")
d <- pdf_to_png(file)