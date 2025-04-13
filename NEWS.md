# 5.3.6

- CRAN fixes (Mac, Windows, clang19):
  - Creates a platform-specific `tesseract_config.h` during the configure step
  - Performs API detection only once during configuration 
  - Properly defines the API compatibility macro
  - Ensures the compiler knows which API to use consistently

# 5.3.3

- This is a fork of the original tesseract package made by Jeroen Ooms. The
  differences are:
    - Uses 'cpp11' instead of 'Rcpp'.
    - Provides functions to download and use the slower but more accurate
      models.
    - Provides functions to download and use contributed models.
    - The documentation works offline.
    - Explicitly tests on Ubuntu with Tesseract 4 (Ubuntu 22.04 default) and
      Tesseract 5 (PPA).
    - The function to download images from the web was removed to comply with
      Munk security policies. The images should be downloaded locally, and once
      verified, these should be uploaded to the server.
    - Tests that the installed Tesseract version is compatible with the C++
      compiler used to compile the package.
    - Does not use autobrew to install dependencies on macOS.
    - Uses 'cpp11poppler' instead of 'pdftools' and removed the 'magick'
      dependency.
