#' Function adding URL or local path of the data set to meta data
#'
#'Function adding URL or local path of the data set to meta data 
#'
#' @param character, supported values, "BoE" and "local";  Name of FO system 
#' @param Dateto Cut date for the pushed dataset
#' @param meta.data 
#'
#' @return Data frame with and additional string column 'url' containging path to the dataset
#' @export
#'
#' @examples AddUrlToMetaData("BoE",Sys.Date(),meta.data)
#
# DEMO: show that missing parameter invokes an error on devtools::document() 
# DEMO: show that comments are extracted into web based documentation
#
AddUrlToMetaData <- function(FO, Dateto, meta.data){
  if( missing(FO) ){
    stop("FO argument is missing")  
  }
  else if ( missing(Dateto) ){
    stop("Dateto argument is missing")
  }
  else if ( missing(meta.data) ){
    stop("meta.data argument is missing")
  }
    else if(!any(FO == c("BoE","local"))){
    stop("FO argument does not correspond to a supported FO system") 
  }
  else if(class(Dateto) != "Date"){
    stop("Dateto is not an instance of Date class") 
  }
  else if(class(meta.data) != "data.frame"){
    stop("meta.data is not an instance of data.frame class") 
  }
  else{
    
    #current working directory
    cwd <-getwd()
    
    if(FO == "BoE"){
      
      #MAYBE: test that the current directory contains the required R script
      source(paste(cwd,"R","make.url.BOE.R",sep="/"), echo=TRUE)
      
      #adding a new empty column to meta.data
      meta.data["url"] <- ""
      
      #updating new column using make.url.BOE function
      #TODO: vectorise this
      for (irow in 1:nrow(meta.data)){
        meta.data[irow,"url"] <- make.url.BOE( 
          meta.data[irow,"SeriesName"], as.Date(meta.data[irow,"DateFrom"], format = "%d/%b/%Y"), Dateto)
      }
    }
    else if (FO == "local"){
      
      #paths of the datasets in the local repository
      #TODO: vectorise thiss
      for (irow in nrow(meta.data)){
        meta.data[irow,"url"] <- file.path(cwd,"data",paste(meta.data[irow,"SeriesName"],"csv",sep="."))
      }
    }
    
    return(meta.data)
  }
}