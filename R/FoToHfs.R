#' Function emulating data transfer from a front office system to Hadoop
#'
#'This function emulates data transfer from a front office system to Hadoop file system. 
#'
#' @param character, supported values, "BoE" and "local";  Name of FO system 
#' @param Dateto Cut date for the pushed dataset
#' @param Fo.meta.data 
#'
#' @return NULL
#' @export
#'
#' @examples FoToHfs()
#
# DEMO: show that missing parameter invokes an error on devtools::document() 
# DEMO: show that comments are extracted into web based documentation
#
FoToHfs <- function(meta.data){
 if ( missing(meta.data) ){
    stop("meta.data argument is missing")
  }
  else if(class(meta.data) != "data.frame"){
    stop("meta.data is not an instance of data.frame class") 
  }
  else{
    
    #read the required data set as specified by meta data
    for (irow in 1:nrow(meta.data)){
      assign(meta.data[irow,"SeriesName"], read.csv(meta.data[irow,"url"]))
    }

    #PUSH the data to Hadoop
    #NOTE: function KNOWS getwd() and data paths
    save(list = c(meta.data[,"SeriesName"]), file = file.path(getwd(),"data","Hadoop.Rdata") )
    
    return()
  }
}