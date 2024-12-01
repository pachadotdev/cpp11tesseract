test_that("tesseract_download works", {
  expect_no_error(tesseract_download("ron", datapath = tempdir(), model = "fast"))
  expect_error(tesseract_download("rou", datapath = tempdir(), model = "fast"))

  expect_warning(tesseract_contributed_download("grc_hist", datapath = tempdir(), model = "fast"))
  
  # if OS is Linux
  if (identical(.Platform$OS.type, "unix") && !identical(Sys.info()[["sysname"]], "Darwin")) {
    expect_warning(warn_on_linux())
  }
})
