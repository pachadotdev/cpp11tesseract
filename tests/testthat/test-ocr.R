test_that("ocr works", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")
  numbers <- tesseract()
  expect_output(cat(ocr(file)))
})

test_that("ocr works with engine parameter", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")
  numbers <- tesseract()
  expect_output(cat(ocr(file, engine = "eng")))
})

test_that("ocr works with whitelisted characters", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")
  numbers <- tesseract(options = list(tessedit_char_whitelist = "-$.0123456789"))
  expect_output(cat(ocr(file, engine = numbers)))
  expect_type(engine_info_internal(numbers)$datapath, "character")
})

test_that("ocr works with raw image", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")
  raw <- readBin(file, "raw", file.info(file)$size)
  expect_output(cat(ocr(raw)))
})

test_that("ocr fails with bad parameters", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")
  expect_error(ocr(file, engine = "enochian"))
  expect_error(ocr(NULL))
})
