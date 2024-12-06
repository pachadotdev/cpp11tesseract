test_that("ocr_data works", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")

  expect_type(ocr_data(file), "list")
  expect_type(ocr_data(file, engine = "eng"), "list")

  expect_error(ocr_data(file, engine = NULL))

  img <- magick::image_read(file)
  expect_type(ocr_data(img, engine = "eng"), "list")

  raw_bytes <- magick::image_write(img, format = "png")
  expect_type(ocr_data(raw_bytes, engine = "eng"), "list")

  expect_error(ocr_data(NULL))
})
