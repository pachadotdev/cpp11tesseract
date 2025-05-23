#' Tesseract Training Data
#'
#' Helper function to download training data from the official
#' [tessdata](https://tesseract-ocr.github.io/tessdoc/Data-Files) repository.
#' On Linux, the fast training data can be installed directly with
#' yum or apt-get.
#'
#' Tesseract uses training data to perform OCR. Most systems default to English
#' training data. To improve OCR performance for other languages you can to
#' install the training data from your distribution. For example to install the
#' spanish training data:
#'
#'  - tesseract-ocr-spa (Debian, Ubuntu)
#'  - tesseract-langpack-spa (Fedora, EPEL)
#'
#' On Windows and MacOS you can install languages using the [tesseract_download]
#' function which downloads training data directly from
#' [github](https://github.com/tesseract-ocr/tessdata)
#' and stores it in a the path on disk given by the `TESSDATA_PREFIX` variable.
#'
#' @export
#' @return no return value, called for side effects
#' @aliases tessdata
#' @rdname tessdata
#' @family tesseract
#' @param lang three letter code for language, see
#' [tessdata](https://github.com/tesseract-ocr/tessdata) repository.
#' @param model either `fast` or `best` is currently supported. The latter
#' downloads more accurate (but slower) trained models for Tesseract 4.0 or
#' higher
#' @param datapath destination directory where to download store the file
#' @param progress print progress while downloading
#' @references
#' [tesseract wiki: training data](https://tesseract-ocr.github.io/tessdoc/Data-Files)
#' @examples
#' # download the french training data
#' # this is wrapped around a \donttest{} block because otherwise the clang19
#' # CRAN check will fail with a "> 5 seconds" message
#' \donttest{
#'  dir <- tempdir()
#'  tesseract_download("fra", model = "best", datapath = dir)
#'  file <- system.file("examples", "french.png", package = "cpp11tesseract")
#'  text <- ocr(file, engine = tesseract("fra", datapath = dir))
#'  cat(text)
#' }
tesseract_download <- function(lang, model = c("fast", "best"),
  datapath = NULL, progress = interactive()) {
  stopifnot(is.character(lang))
  model <- match.arg(model)
  if (!length(datapath)) {
    warn_on_linux()
    datapath <- tesseract_info()$datapath
  }
  datapath <- normalizePath(datapath, mustWork = TRUE)
  version <- tesseract_version_major()

  if (version < 4) {
    repo <- "tessdata"
    release <- "3.04.00"
  } else {
    repo <- paste0("tessdata_", model)
    release <- "4.1.0"
  }
  url <- sprintf("https://github.com/tesseract-ocr/%s/raw/%s/%s.traineddata",
    repo, release, lang)
  download_helper(url, datapath, progress)
}

#' Tesseract Contributed Training Data
#'
#' Helper function to download training data from the contributed
#' [tessdata_contrib](https://github.com/tesseract-ocr/tessdata_contrib)
#' repository.
#'
#' @export
#' @return no return value, called for side effects
#' @aliases tessdata
#' @rdname tessdata
#' @family tesseract
#' @seealso [tesseract_download]
#' @param lang three letter code for language, see
#' [tessdata](https://github.com/tesseract-ocr/tessdata) repository.
#' @param model either `fast` or `best` is currently supported. The latter
#' downloads more accurate (but slower) trained models for Tesseract 4.0 or
#' higher
#' @param datapath destination directory where to download store the file
#' @param progress print progress while downloading
#' @references
#' [tesseract wiki: training data](https://tesseract-ocr.github.io/tessdoc/Data-Files)
#' @examples
#' # download the greek training data
#' # this is wrapped around a \donttest{} block because otherwise the clang19
#' # CRAN check will fail with a "> 5 seconds" message
#' \donttest{
#'  dir <- tempdir()
#'  tesseract_contributed_download("grc_hist", model = "best", datapath = dir)
#'  file <- system.file("examples", "polytonicgreek.png",
#'    package = "cpp11tesseract")
#'  text <- ocr(file, engine = tesseract("grc_hist", datapath = dir))
#'  cat(text)
#' }
tesseract_contributed_download <- function(lang, model = c("fast", "best"),
  datapath = NULL, progress = interactive()) {
  stopifnot(is.character(lang))
  if (!any(lang %in% c("grc_hist", "akk"))) {
    stop(paste("The only available contributed models are Akkadian and",
      "Polytonic Greek (for now)."), call. = FALSE)
  }
  model <- match.arg(model)
  if (!length(datapath)) {
    warn_on_linux()
    datapath <- tesseract_info()$datapath
  }
  datapath <- normalizePath(datapath, mustWork = TRUE)
  version <- tesseract_version_major()

  if (lang == "grc_hist" && version < 4) {
    stop(paste("The Polytonic Greek model is only available for Tesseract 4.0",
      "or higher."), call. = FALSE)
  }

  if (lang == "grc_hist") {
    if (model == "fast") {
      warning(paste("The Polytonic Greek model is only available in 'best'",
        "quality."), call. = FALSE)
    }
    release <- "grc_hist/best"
  }

  if (lang == "akk" && version < 4) {
    release <- "akk/legacy"
  } else if (lang == "akk" && model == "best") {
    release <- "akk/best"
  } else if (lang == "akk" && model == "fast") {
    release <- "akk/fast"
  }

  url <- sprintf(paste0("https://github.com/tesseract-ocr/tessdata_contrib/",
    "raw/main/%s/%s.traineddata"), release, lang)
  print(url)

  download_helper(url, datapath, progress)
}

download_helper <- function(url, datapath, progress) {
  destfile <- file.path(datapath, basename(url))

  if (file.exists(destfile)) {
    message("The training data already exists. Skipping download.")
    return(destfile)
  }

  req <- curl::curl_fetch_memory(url, curl::new_handle(
    progressfunction = progress_fun,
    noprogress = !isTRUE(progress)
  ))

  if (progress) {
    cat("\n")
  }
  if (req$status_code != 200) {
    stop("Download failed: HTTP ", req$status_code, call. = FALSE)
  }
  writeBin(req$content, destfile)
  return(destfile)
}

progress_fun <- function(down, up) {
  total <- down[[1]]
  now <- down[[2]]
  pct <- if (length(total) && total > 0) {
    paste0("(", round(now / total * 100), "%)")
  } else {
    ""
  }
  if (now > 10000) {
    cat("\r Downloaded:", sprintf("%.2f", now / 2^20), "MB ", pct)
  }
  TRUE
}

warn_on_linux <- function() {
  if (identical(.Platform$OS.type, "unix") &&
      !identical(Sys.info()[["sysname"]], "Darwin")) {
    warning("On Linux you should install training data via yum/apt. Please
      check the manual page.", call. = FALSE)
  }
}
