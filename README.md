
# FileList

<!-- badges: start -->
<!-- badges: end -->

FileList creates csv files of file list in any directory.

## Installation

You can install the development version of FileList from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("KanaTerayama/FileList")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(FileList)
## basic example code
#path is the file path to the directory containing the directory for which you want to create a file list
#You can use tistamp as "ctime", "mtime", and "atime"
FileList(path,tmstamp="mtime")
```

