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
FoToHfs <- function(FO, Dateto, Fo.meta.data){
  if( missing(FO) ){
    stop("FO argument is missing")  
  }
  else if ( missing(Dateto) ){
    stop("Dateto argument is missing")
  }
  else if ( missing(Fo.meta.data) ){
    stop("Fo.meta.data argument is missing")
  }
    else if(!any(FO == c("BoE","local"))){
    stop("FO argument does not correspond to a supported FO system") 
  }
  else if(class(Dateto) != "Date"){
    stop("Dateto is not an instance of Date class") 
  }
  else if(class(Fo.meta.data) != "data.frame"){
    stop("Fo.meta.data is not an instance of data.frame class") 
  }
  else{
    
    #current working directory
    cwd <-getwd()
    
    if(FO == "BoE"){
      
      #MAYBE: test that the current directory contains the required R script
      source(paste(cwd,"R","make.url.BOE.R",sep="/"), echo=TRUE)
      
      tmp.meta.data <- cbind(Fo.meta.data, url = c(NULL))
      
      #RPQTFHD: Quarterly amounts UK resident monetary financial institutions' sterling write-offs 
      #of lending secured on dwellings to individuals (in sterling millions) not seasonally adjusted
      
      #earliest date for the dataset in the database
      Datefrom <- as.Date("31/Mar/1993",format = "%d/%b/%Y")
      
      RPQTFHD.url <- make.url.BOE("RPQTFHD", Datefrom, Dateto)
      
      #RPQB7YW: Quarterly amounts outstanding UK resident banks and building societies sterling net 
      #secured lending to individuals (in sterling millions) not seasonally adjusted
      
      RPQB7YW.url <- make.url.BOE("RPQB7YW", Datefrom, Dateto)
    }
    else if (FO == "local"){
      
      #paths of the datasets in the local repository
      RPQTFHD.url <- file.path(cwd,"data","RPQTFHD.csv")
      RPQB7YW.url <- file.path(cwd,"data","RPQTFHD.csv")
    }
    
    RPQTFHD <- read.csv(RPQTFHD.url)
    RPQB7YW <- read.csv(RPQB7YW.url)
    
    #save the data to Hadoop
    save(RPQTFHD, RPQB7YW, file = file.path(cwd,"data","Hadoop.Rdata") )
    
    return()
  }
}