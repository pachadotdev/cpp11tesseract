test_that("ocr works", {
  file <- system.file("examples", "mrdukeexpenditure.pdf", package = "cpp11tesseract")
  expect_output(cat(ocr(file, engine = "eng")))
  expect_error(ocr(file, engine = "enochian"))

  # test engine options

  numbers <- tesseract(options = list(tessedit_char_whitelist = "-$.0123456789"))
  expect_output(cat(ocr(file, engine = numbers)))

  numbers <- tesseract()
  expect_output(cat(ocr(file)))

  expect_type(engine_info_internal(tesseract("eng")), "list")
  expect_equal(get_param_values(tesseract("eng"), ""), "")

  # multi-page pdf
  
  file <- system.file("examples", "bondargentina.pdf", package = "cpp11tesseract")

  n <- n_pages(file, "", "")
  expect_equal(n, 2L)
  parsed_text <- ocr(file, engine = "eng")
  expect_equal(length(parsed_text), 2L)
  expect_equal(length(ocr(file, engine = "eng", pages = 1)), 1L)
  expect_equal(length(ocr(file, engine = "eng", pages = 2)), 1L)

  # pass null

  expect_error(ocr(NULL))
})
