test_that("tesseract_params works", {
  expect_type(tesseract_params("colour"), "list")
})

test_that("tesseract_params works", {
  fout <- tempfile(fileext = ".txt")
  writeLines("colour", fout)
  expect_type(parse_params(fout), "list")
})
