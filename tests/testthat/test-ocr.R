test_that("ocr works", {
  file <- system.file("examples", "receipt.jpg", package = "cpp11tesseract")
  
  # test engine options

  numbers <- tesseract(options = list(tessedit_char_whitelist = "-$.0123456789"))
  expect_output(cat(ocr(file, engine = numbers)))

  numbers <- tesseract()
  expect_output(cat(ocr(file)))

  numbers <- tesseract()
  expect_output(cat(ocr(file, engine = "eng")))

  # pass a magick-image

  img <- magick::image_read(file)
  expect_output(cat(ocr(img)))

  # convert image to raw bytes

  raw_bytes <- magick::image_write(img, format = "png")
  expect_output(cat(ocr(raw_bytes)))

  # pass nul

  expect_error(ocr(NULL))
})
