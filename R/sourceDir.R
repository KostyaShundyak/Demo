#' Read R code from all files in a directory
#'
#'Sources all R codes from from all .[RrSsQq] files in a directory
#'
#' @param path Full path to the directory
#' @param trace logical: if TRUE, each file name is printed before sourcing
#' @param ... 
#'
#' @return TBC
#' @export
#'
#' @examples sourceDir(".")
sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")           
    
    source(file.path(path, nm), ...)
    
    if(trace) cat("\n")
  }
}