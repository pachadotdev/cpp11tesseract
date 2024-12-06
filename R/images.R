is.pdf <- function(x) {
  grepl("\\.pdf$", tolower(x))
}

is.tiff <- function(x) {
  grepl("\\.tiff$", tolower(x))
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

  filenames <- file.path(dout, sprintf("%s-%03d.%s",
    # basename(pdf),
    # remove the file extension
    tools::file_path_sans_ext(basename(pdf)),
    pages, format)
  )

  poppler_convert(pdf, format, pages, filenames, dpi, opw, upw, antialiasing, text_antialiasing)
}

tiff_convert <- function(tiff, format = "png", dpi = 72) {
  stopifnot(requireNamespace("magick", quietly = TRUE))
  magick::image_convert(magick::image_read(tiff), format = format)
}
