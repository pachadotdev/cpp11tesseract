## R CMD check results

0 errors | 0 warnings | 1 note

* This is a corrected release (5.3.3)
* Changes:
  * 'configure' tests that the installed Tesseract version is compatible
    with the C++ compiler (requested by Prof. Brian Ripley, CRAN).
  * Adds Tesseract as a MacOS requirement (via brew) and does not use autobrew
    to install it (i.e., to adhere to CRAN policies).
