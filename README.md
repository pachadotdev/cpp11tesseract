
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cpp11tesseract

[![R-CMD-check](https://github.com/pachadotdev/cpp11tesseract/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/pachadotdev/cpp11tesseract/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/pachadotdev/cpp11tesseract/graph/badge.svg?token=mWfiUCgfNu)](https://app.codecov.io/gh/pachadotdev/cpp11tesseract)
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![CRAN
status](https://www.r-pkg.org/badges/version/cpp11tesseract)](https://CRAN.R-project.org/package=cpp11tesseract)
[![BuyMeACoffee](https://raw.githubusercontent.com/pachadotdev/buymeacoffee-badges/main/bmc-donate-white.svg)](https://buymeacoffee.com/pacha)

`cpp11tesseract` is a fork of `tesseract` that uses `cpp11` for those
that require it for licensing or security purposes. It provides bindings
to [Tesseract-OCR](https://opensource.google/projects/tesseract), a
powerful optical character recognition (OCR) engine that supports over
100 languages. The engine is highly configurable in order to tune the
detection algorithms and obtain the best possible results.

  - Upstream Tesseract-OCR documentation:
    <https://tesseract-ocr.github.io/tessdoc/>
  - Introduction:
    <https://docs.ropensci.org/tesseract/articles/intro.html>
  - Reference: <https://docs.ropensci.org/tesseract/reference/ocr.html>

## Simple example

How to extract text from an image:

``` r
library(cpp11tesseract)
text <- ocr("inst/examples/wilde.png")
cat(text)
#> Complete Works
#> oF
#> OSCAR WILDE
#> EDITED BY
#> 
#> ROBERT ROSS
#> MISCELLANIES
#> ‘AUTHORIZED EDITION
#> 
#> THE WYMAN-FOGG COMPANY
#> 
#> BOSTON :: MASSACHUSETTS
```

## Differences with the original tesseract R package

This package initially started as a series of modifications to the
original `tesseract` package to improve performance and add new
features. Some of the changes contributed to the original included the
functions to choose between the “best” and “fast” models.

However, some changes were not integrated, such as using the `cpp11`
package, which I need to comply with the Munk School IT standards. Using
`cpp11` allows me to vendor the C++ headers into the package, and then I
can conduct an offline installation in the Niagara Cluster.

The documentation changed a bit. I tried to expand the documentation and
compare with Amazon Textract output.

This package includes some changes requested by CRAN, and these are
mostly about the package internals. For example, this version lists the
dependencies to install in Linux and Mac, that you can install using
apt/yum/brew, while the original package uses autobrew to install the
Mac dependencies as binaries.

## Installation

Installation from source on Linux or OSX requires the `Tesseract`
library (see below).

### Install from source

On Debian or Ubuntu install libtesseract-dev, libleptonica-dev, and
tesseract-ocr-eng to run examples.

``` bash
sudo apt-get install -y libtesseract-dev libleptonica-dev tesseract-ocr-eng
```

On Ubuntu you can optionally use [this
PPA](https://launchpad.net/~alex-p/+archive/ubuntu/tesseract-ocr-devel)
to get the latest version of Tesseract:

``` bash
sudo add-apt-repository ppa:alex-p/tesseract-ocr-devel
sudo apt-get install -y libtesseract-dev tesseract-ocr-eng
```

On Fedora you need
[tesseract-devel](https://src.fedoraproject.org/rpms/tesseract) and
[leptonica-devel](https://src.fedoraproject.org/rpms/leptonica)

``` bash
sudo yum install tesseract-devel leptonica-devel
```

On RHEL and CentOS you need
[tesseract-devel](https://src.fedoraproject.org/rpms/tesseract) and
[leptonica-devel](https://src.fedoraproject.org/rpms/leptonica) from
EPEL

``` bash
sudo yum install epel-release
sudo yum install tesseract-devel leptonica-devel
```

On OS-X use
[tesseract](https://github.com/Homebrew/homebrew-core/blob/master/Formula/tesseract.rb)
from Homebrew:

``` bash
brew install tesseract
```

Tesseract uses training data to perform OCR. Most systems default to
English training data. To improve OCR results for other languages you
can to install the appropriate training data. On Windows and OSX you can
do this in R using `tesseract_download()`:

``` r
tesseract_download('fra')
```

On Linux you need to install the appropriate training data from your
distribution. For example to install the spanish training data you need
tesseract-ocr-spa (Debian, Ubuntu) or tesseract-langpack-spa (Fedora,
EPEL).

Alternatively you can manually download training data from
[github](https://github.com/tesseract-ocr/tessdata) and store it in a
path on disk that you pass in the `datapath` parameter or set a default
path via the `TESSDATA_PREFIX` environment variable. Note that the
Tesseract 4 and Tesseract 3 use different training data format. Make
sure to download training data from the branch that matches your
libtesseract version.

## Testing with docker (development)

``` bash
mkdir check
docker run -v `pwd`/check:/check ghcr.io/r-hub/containers/clang19:latest apt install apt-utils libcurl4-openssl-dev &\
  R -q -e "install.packages(c('Rcpp', 'jsonlite', 'curl', 'httr', 'yaml', 'rex', 'digest', 'crayon', 'withr', 'cli', 'magick', 'processx', 'tibble', 'V8', 'testthat', 'mockery', 'whoami', 'covr', 'asciicast'), repos = 'https://cloud.r-project.org')" &\
  r-check
```
