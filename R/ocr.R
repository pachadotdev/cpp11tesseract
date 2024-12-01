#' Tesseract OCR
#'
#' Extract text from an image. Requires that you have training data for the language you
#' are reading. Works best for images with high contrast, little noise and horizontal text.
#' See [tesseract wiki](https://github.com/tesseract-ocr/tessdoc) and
#' the package vignette for image preprocessing tips.
#'
#' The `ocr()` function returns plain text by default, or hOCR text if hOCR is set to `TRUE`.
#'
#' @export
#' @return character vector of text extracted from the file. If the file
#'  is has TIFF or PDF extension, it will be a vector of length equal to the
#'  number of pages.
#' @family tesseract
#' @param file file path or raw vector (png, tiff, jpeg, etc).
#' @param pages a numeric vector of pages to extract text from. If `NULL` all
#'  pages will be extracted.
#' @param engine a tesseract engine created with [tesseract()]. Alternatively a
#' language string which will be passed to [tesseract()].
#' @param HOCR if `TRUE` return results as HOCR xml instead of plain text
#' @param opw owner password to open pdf (please pass it as an environment
#'  variable to avoid leaking sensitive information)
#' @param upw user password to open pdf (please pass it as an environment
#'  variable to avoid leaking sensitive information)
#' @rdname ocr
#' @references [Tesseract: Improving Quality](https://github.com/tesseract-ocr/tesseract/wiki/ImproveQuality)
#' @examples
#' # Simple example
#' file <- system.file("examples", "oscarwilde.pdf", package = "cpp11tesseract")
#' text <- ocr(file)
#' cat(text)
ocr <- function(file, pages = NULL, engine = tesseract("eng"), HOCR = FALSE, opw = "", upw = "") {
  if (is.character(engine)) { engine <- tesseract(engine) }
  if (is.numeric(pages)) { pages <- as.integer(pages) }
  stopifnot(inherits(engine, "externalptr"))
  stopifnot(file.exists(file))
  stopifnot(is.pdf(file))

  if (is.null(pages)) { pages <- seq_len(n_pages(file, opw = opw, upw = upw)) }
  fout <- pdf_convert(file, format = "png", pages = pages, opw = opw, upw = upw)
  out <- vapply(fout, ocr_file, character(1), ptr = engine, HOCR = HOCR, USE.NAMES = FALSE)
  unlink(fout)
  out
}

is.pdf <- function(x) {
  grepl("\\.pdf$", tolower(x))
}

pdf_convert <- function(pdf, format = "png", pages = NULL, dpi = 72,
                        antialias = TRUE, opw = "", upw = "") {
  config <- get_poppler_config()

  if (isFALSE(config$render) || isFALSE(length(config$format) > 0)) {
    stop("You version of libppoppler does not support rendering")
  }

  format <- match.arg(format, config$format)

  if (is.null(pages)) {
    pages <- seq_len(n_pages(file, opw = opw, upw = upw))
  }

  if (isFALSE(is.numeric(pages)) || isFALSE(length(pages) > 0)) {
    stop("Argument 'pages' must be a one-indexed vector of page numbers")
  }

  antialiasing <- isTRUE(antialias) || isTRUE(antialias == "draw")

  text_antialiasing <- isTRUE(antialias) || isTRUE(antialias == "text")

  dout <- tempdir()
  suppressWarnings(try(dir.create(dout)))

  filenames <- file.path(dout, sprintf(
    "%s-%03d.%s",
    tools::file_path_sans_ext(basename(pdf)),
    pages, format
  ))

  poppler_convert(pdf, format, pages, filenames, dpi, opw, upw, antialiasing, text_antialiasing)
}
