.onLoad <- function(lib, pkg) {
  pkgdir <- file.path(lib, pkg)
  version <- tesseract_version_major()
  appname <- ifelse(version < 4, "tesseract", paste0("tesseract", version))
  sysdir <- tools::R_user_dir(appname, which = "data")
  pkgdata <- normalizePath(file.path(pkgdir, "tessdata"), mustWork = FALSE)
  sysdata <- normalizePath(file.path(sysdir, "tessdata"), mustWork = FALSE)
  if (!is_testload() && file.exists(pkgdata) && !file.exists(file.path(sysdata, "eng.traineddata"))) {
    dir.create(sysdir, showWarnings = FALSE, recursive = TRUE)
    if (file.exists(sysdir)) {
      onload_notify()
      tempdir <- tempdir()
      on.exit(setwd(tempdir))
      setwd(pkgdir)
      file.copy("tessdata", sysdir, recursive = TRUE)
    }
  }
  if (is.na(Sys.getenv("TESSDATA_PREFIX", NA))) {
    if (file.exists(file.path(sysdata, "eng.traineddata"))) {
      Sys.setenv(TESSDATA_PREFIX = sysdata)
    } else if (file.exists(file.path(pkgdata, "eng.traineddata"))) {
      Sys.setenv(TESSDATA_PREFIX = pkgdata)
    }
  }

  if (grepl("tesseract.Rcheck", tempdir(), fixed = TRUE)) {
    Sys.setenv(OMP_THREAD_LIMIT = 2)
    Sys.setenv(OMP_NUM_THREADS = 2)
  }
}

tesseract_version_major <- function() {
  as.numeric(substring(tesseract_config()$version, 1, 1))
}

onload_notify <- function() {
  message("First use of Tesseract: copying language data...\n")
}

is_testload <- function() {
  as.logical(nchar(Sys.getenv("R_INSTALL_PKG")))
}

.onUnload <- function(lib) {
  Sys.unsetenv("TESSDATA_PREFIX")
}

.onAttach <- function(lib, pkg) {
  check_training_data()

  # Load tibble (if available) for pretty printing
  if (interactive() && is.null(.getNamespace("tibble"))) {
    tryCatch(
      {
        getNamespace("tibble")
      },
      error = function(e) {}
    )
  }
}

check_training_data <- function() {
  tryCatch(tesseract(), error = function(e) {
    warning("Unable to find English training data", call. = FALSE)
    os <- utils::sessionInfo()$running
    if (isTRUE(grepl("ubuntu|debian|pop", os, TRUE))) {
      stop("DEBIAN / UBUNTU: Please run: apt-get install tesseract-ocr-eng")
    }
  })
}
