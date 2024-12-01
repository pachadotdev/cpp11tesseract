test_that("tesseract_params works", {
  expect_type(tesseract_params("colour"), "list")
})

test_that("tesseract_params works", {
  fout <- tempfile(fileext = ".txt")
  writeLines("colour", fout)
  expect_type(parse_params(fout), "list")
})

test_that("tesseract version", {
  expect_type(tesseract_major_version(), "integer")
  expect_gt(length(tesseract_info()$available), 0)
  expect_type(check_training_data(), "externalptr")
})
