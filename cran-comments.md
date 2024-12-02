## R CMD check results

0 errors | 0 warnings | 1 note

* This is a corrected release (5.3.3)
* Changes:
  * 'configure' tests that the installed Tesseract version is compatible
    with the C++ compiler (requested by Prof. Brian Ripley, CRAN).
  * Adds Tesseract as a MacOS requirement (via brew) and does not use autobrew
    to install it - requested by CRAN on an email.
  * Uses 'pdftools' conditionally. Btw, I cannot get to install pdftools
    on the Niagara cluster, meaning that it is that package that has an issue
    with clang 19.
  * The notes for r-release-macos-arm64 - r-oldrel-windows-x86_64 were fixed
    by moving as much as possible to system packages that can be installed with
    'apt-get' or similar.
* CRAN shows this for 5.3.2 on r-devel-linux-x86_64-debian-gcc , I think
  I don't have a way to change your server
  permissions from my side:
  "installing to library
  ‘/home/hornik/tmp/R.check/r-devel-gcc/Work/build/Packages’
  Error: ERROR: no permission to install to directory
  ‘/home/hornik/tmp/R.check/r-devel-gcc/Work/build/Packages’"
* The warnings with clang19 (and clang-asan) were solved by sending a pull
  request to Posit (https://github.com/r-lib/cpp11/pull/404/files). This
  fix required to patch a package used by readpdf and add a conditional
  to avoid redeclaring STRICT_R_HEADERS.
