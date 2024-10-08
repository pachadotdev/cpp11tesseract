#' Tesseract OCR
#'
#' Extract text from an image. Requires that you have training data for the language you
#' are reading. Works best for images with high contrast, little noise and horizontal text.
#' See [tesseract wiki](https://github.com/tesseract-ocr/tessdoc) and
#' our package vignette for image preprocessing tips.
#'
#' The `ocr()` function returns plain text by default, or hOCR text if hOCR is set to `TRUE`.
#' The `ocr_data()` function returns a data frame with a confidence rate and bounding box for
#' each word in the text.
#'
#' @export
#' @return character vector of text extracted from the image
#' @family tesseract
#' @param image file path, url, or raw vector to image (png, tiff, jpeg, etc)
#' @param engine a tesseract engine created with [tesseract()]. Alternatively a
#' language string which will be passed to [tesseract()].
#' @param HOCR if `TRUE` return results as HOCR xml instead of plain text
#' @rdname ocr
#' @references [Tesseract: Improving Quality](https://github.com/tesseract-ocr/tesseract/wiki/ImproveQuality)
#' @examples 
#' # Simple example
#' file <- system.file("examples", "testocr.png", package = "cpp11tesseract")
#' text <- ocr(file)
#' cat(text)
ocr <- function(image, engine = tesseract("eng"), HOCR = FALSE) {
  if (is.character(engine)) {
    engine <- tesseract(engine)
  }
  stopifnot(inherits(engine, "externalptr"))
  if (inherits(image, "magick-image")) {
    vapply(image, function(x) {
      tmp <- tempfile(fileext = ".png")
      on.exit(unlink(tmp))
      magick::image_write(x, tmp, format = "PNG", density = "300x300")
      ocr(tmp, engine = engine, HOCR = HOCR)
    }, character(1))
  } else if (is.character(image)) {
    image <- download_files(image)
    vapply(image, ocr_file, character(1), ptr = engine, HOCR = HOCR, USE.NAMES = FALSE)
  } else if (is.raw(image)) {
    ocr_raw(image, engine, HOCR = HOCR)
  } else {
    stop("Argument 'image' must be file-path, url or raw vector")
  }
}

#' @rdname ocr
#' @export
ocr_data <- function(image, engine = tesseract("eng")) {
  if (is.character(engine)) {
    engine <- tesseract(engine)
  }
  stopifnot(inherits(engine, "externalptr"))
  df_list <- if (inherits(image, "magick-image")) {
    lapply(image, function(x) {
      tmp <- tempfile(fileext = ".png")
      on.exit(unlink(tmp))
      magick::image_write(x, tmp, format = "PNG", density = "300x300")
      ocr_data(tmp, engine = engine)
    })
  } else if (is.character(image)) {
    image <- download_files(image)
    lapply(image, function(im) {
      ocr_file_data(im, ptr = engine)
    })
  } else if (is.raw(image)) {
    list(ocr_raw_data(image, engine))
  } else {
    stop("Argument 'image' must be file-path, url or raw vector")
  }
  df_as_tibble(do.call(rbind.data.frame, unname(df_list)))
}
