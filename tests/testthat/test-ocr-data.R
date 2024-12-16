test_that("ocr_data works", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")

  expect_type(ocr_data(file), "list")
  expect_type(ocr_data(file, engine = "eng"), "list")

  expect_error(ocr_data(file, engine = NULL))

  expect_error(ocr_data(NULL))
})
