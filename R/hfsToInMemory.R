#' Imports data from Hadoop file system to memory
#'
#' Imports data from Hadoop file system to memory
#'
#' @param hfsFile file name in HFS
#'
#' @return A character vector of the names of objects created, invisibly.
#' @export
#'
#' @examples hfsToInMemory("Hadoop.Rdata")
hfsToInMemory <- function(hfsFile){
  cwd <- getwd()
  if(missing(hfsFile)){
    stop("hfsFile argument is missing")  
  }
  else if(class(hfsFile) != "character"){
    stop("hfsFile is not an instance of character class")
  }
  else if( !( file.exists( fpath <- file.path(getwd(),"data",hfsFile))) ){
    stop("hfsFile argument does not point to the existing file in data repository") 
  }
  else{
    return( load(fpath, envir = parent.frame()) )
  }
}