# Tesseract ----

if (!file.exists("../windows/tesseract/include/tesseract/baseapi.h")) {
  unlink("../windows/tesseract", recursive = TRUE)
  url <- if (grepl("aarch", R.version$platform)) {
    "https://github.com/pachadotdev/cpp11tesseract/releases/download/tesseract-5.3.2/tesseract-ocr-5.3.2-clang-aarch64.tar.xz"
  } else if (grepl("clang", Sys.getenv("R_COMPILED_BY"))) {
    "https://github.com/pachadotdev/cpp11tesseract/releases/download/tesseract-5.3.2/tesseract-ocr-5.3.2-clang-x86_64.tar.xz"
  } else if (getRversion() >= "4.3") {
    "https://github.com/pachadotdev/cpp11tesseract/releases/download/tesseract-5.3.2/tesseract-ocr-5.3.2-ucrt-x86_64.tar.xz"
  }
  download.file(url, basename(url), quiet = TRUE)
  untar(basename(url), exdir = "../windows/", tar = "internal")
  file.rename(file.path("../windows", dir("../windows", pattern = "tesseract-ocr-")), "../windows/tesseract")
  unlink(basename(url))
}

dir.create("../windows/tessdata", showWarnings = FALSE)
if (!file.exists("../windows/tessdata/eng.traineddata")) {
  message("Downloading eng.traineddata...")
  download.file("https://github.com/tesseract-ocr/tessdata_fast/raw/4.1.0/eng.traineddata",
    "../windows/tessdata/eng.traineddata",
    mode = "wb", quiet = TRUE
  )
}

if (!file.exists("../windows/tessdata/osd.traineddata")) {
  message("Downloading osd.traineddata...")
  download.file("https://github.com/tesseract-ocr/tessdata_fast/raw/4.1.0/osd.traineddata",
    "../windows/tessdata/osd.traineddata",
    mode = "wb", quiet = TRUE
  )
}

# Poppler ----

if (!file.exists("../windows/poppler/include/poppler/cpp/poppler-document.h")) {
  unlink("../windows/poppler", recursive = TRUE)
  url <- if (grepl("aarch", R.version$platform)) {
    "https://github.com/pachadotdev/cpp11tesseract/releases/download/poppler-23.08.0/poppler-23.08.0-clang-aarch64.tar.xz"
  } else if (grepl("clang", Sys.getenv("R_COMPILED_BY"))) {
    "https://github.com/pachadotdev/cpp11tesseract/releases/download/poppler-23.08.0/poppler-23.08.0-clang-x86_64.tar.xz"
  } else if (getRversion() >= "4.3") {
    "https://github.com/pachadotdev/cpp11tesseract/releases/download/poppler-23.08.0/poppler-23.08.0-ucrt-x86_64.tar.xz"
  }
  download.file(url, basename(url), quiet = TRUE)
  untar(basename(url), exdir = "../windows/", tar = "internal")
  file.rename(file.path("../windows", dir("../windows", pattern = "poppler-")), "../windows/poppler")
  unlink(basename(url))
}
