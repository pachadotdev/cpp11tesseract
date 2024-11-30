test_that("tesseract_download works", {
  expect_no_error(tesseract_download("ron", datapath = tempdir(), model = "fast"))
  expect_error(tesseract_download("rou", datapath = tempdir(), model = "fast"))
})
