test_that("parse pdf document", {
  file <- system.file("examples", "bondargentina.pdf", package = "cpp11tesseract")
  n <- n_pages(file, "", "")
  expect_equal(n, 2L)
  parsed_text <- ocr(file, engine = "eng")
  expect_equal(length(parsed_text), 2L)
})

test_that("parse tiff document", {
  file <- system.file("examples", "bondargentina.tiff", package = "cpp11tesseract")
  parsed_text <- ocr(file, engine = "eng")
  expect_equal(length(parsed_text), 2L)
})
