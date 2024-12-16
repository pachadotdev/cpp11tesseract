test_that("ocr works", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")

  # test engine options

  numbers <- tesseract(options = list(tessedit_char_whitelist = "-$.0123456789"))
  expect_output(cat(ocr(file, engine = numbers)))

  expect_type(engine_info_internal(numbers)$datapath, "character")

  numbers <- tesseract()
  expect_output(cat(ocr(file)))

  numbers <- tesseract()
  expect_output(cat(ocr(file, engine = "eng")))

  expect_error(ocr(file, engine = "enochian"))

  # convert image to raw bytes

  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")
  raw <- readBin(file, "raw", file.info(file)$size)
  expect_output(cat(ocr(raw)))

  # pass null

  expect_error(ocr(NULL))
})
