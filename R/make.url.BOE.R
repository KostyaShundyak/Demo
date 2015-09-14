#' URL for accessing Bank of England's data 
#'
#' Generates an URL for accessing Bank of England's data, and returns it as a string
#'
#' @param SeriesCodes Comma separated list of full series codes (mandatory parameter), e.g. LPMAUZI,LPMAVAA
#' @param Datefrom	DD/MON/YYYY (mandatory parameter), e.g. 01/Feb/2006
#' @param Dateto DD/MON/YYYY (mandatory parameter), e.g. 01/Feb/2007
#' @param CSVF "TT" (Tabular with titles), "TN" (Tabular no titles), 
#'        "CT" (Columnar with titles) or "CN" (Columnar no titles). (mandatory parameter)
#' @param UsingCodes "Y" (mandatory parameter)
#' @param VPD "Y" or "N" (optional parameter). 
#'        The "VPD=Y" parameter need only be included if provisional data is desired.
#' @param VFD "Y" or "N" (optional parameter). 
#'        The "VFD=Y" parameter should be supplied if you want to see any observation 
#'        footnotes which have been associated to the selected data observations.
#'
#' @return A string representing URL of the corresponding data on Bank of England's website,
#'        e.g. http://www.bankofengland.co.uk/boeapps/iadb/fromshowcolumns.asp?csv.x=yes&
#'        Datefrom=01/Feb/2006&Dateto=01/Oct/2007 &SeriesCodes=LPMAUZI,LPMAVAA&CSVF=TN&
#'        UsingCodes=Y&VPD=Y&VFD=N
#' @export
#'
#' @examples make.url.BOE("RPQTFHD","31/Mar/1993","06/Aug/2015")
make.url.BOE <- function(SeriesCodes,Datefrom,Dateto,CSVF="TN",UsingCodes="Y",VPD="Y",VFD="N"){
  if( missing(SeriesCodes) ){
    stop("SeriesCodes argument is missing")  
  }
  else if( missing(Datefrom) ){
    stop("Datefrom argument is missing")  
  }
  else if( missing(Dateto) ){
      stop("Dateto argument is missing")  
  }
  
  else if( class(SeriesCodes) != "character" ){
    stop("SeriesCodes is not an instance of character class") 
  }
  else if( class(Datefrom) != "Date" ){
    stop("Datefrom is not an instance of Date class") 
  }
  else if( class(Dateto) != "Date" ){
    stop("Dateto is not an instance of Date class") 
  }
  
  else {
    #constant part of URL as describe on BoE website
    urlStr <- "http://www.bankofengland.co.uk/boeapps/iadb/fromshowcolumns.asp?csv.x=yes"
  
    #string specifying the starting date for analysis
    DatefromStr <- paste("Datefrom",Datefrom,sep="=")
    
    #string specifying the end date for analysis
    DatetoStr <- paste("Dateto",Dateto,sep="=")
    
    #string specifying codes of timeseries on BoE website
    SeriesCodesStr <- paste("SeriesCodes",SeriesCodes,sep="=")
    
    #strings specifying other optional parameters
    CSVFStr <- paste("CSVF",CSVF,sep="=")
    UsingCodesStr <- paste("UsingCodes",UsingCodes,sep="=")
    VPDStr <- paste("VPD",VPD,sep="=")
    VFDStr <- paste("VFD",VFD,sep="=")
    
    #string containing the resulting URL
    fullStr <- paste(urlStr,DatefromStr,DatetoStr,SeriesCodesStr,CSVFStr,UsingCodesStr,VPDStr,VFDStr,sep="&")
    return( fullStr )
  }
}