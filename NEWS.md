# 5.3.3

- Tests that the installed Tesseract version is compatible with the C++ compiler
  (requested by Prof. Brian Ripley, CRAN).
  
# 5.3.2

- Includes changes requested by CRAN (internal changes and reduced size images).

# 5.3.0
  - This is a fork of the original tesseract package made by Jeroen Ooms.
  - Differences:
    - Uses cpp11 instead of Rcpp.
    - Provides functions to download and use the slower but more accurate
      models.
    - Provides functions to download and use contributed models.
    - The documentation works offline.
    - Explicitly tests on Ubuntu with Tesseract 4 (Ubuntu 22.04 default) and
      Tesseract 5 (PPA).
