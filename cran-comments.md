## Test environments

* local: darwin15.6.0-3.6.0
* travis: 3.1, 3.2, 3.3, oldrel, release, devel
* r-hub: windows-x86_64-devel, ubuntu-gcc-release, fedora-clang-devel


## R CMD check results

This is the first submission of this package.

There were no Errors or Warnings. 

There was one note:

*  checking R code for possible problems ... NOTE
   simResponse: no visible binding for global variable ‘rnorm’
   Undefined global functions or variables:
     rnorm
   Consider adding
     importFrom("stats", "rnorm")
   to your NAMESPACE file.
   
   Adding this importFrom generates an Error that it is unneccesary to importFrom
   stats.

