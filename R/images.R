is.tiff <- function(x) {
  grepl("\\.tiff$", tolower(x))
}

tiff_convert <- function(tiff, format = "png", dpi = 72) {
  stopifnot(requireNamespace("magick", quietly = TRUE))
  magick::image_convert(magick::image_read(tiff), format = format)
}
