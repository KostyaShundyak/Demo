#' Auxiliary function generating meta data for the FO system
#'
#' Meta data for the FO system is expected to be generated prior to 
#' data trasfer from FO to HFS
#'
#' @return List emulating FO meta data
#' @export
#'
#' @examples generateFoMetaData()
generateFoMetaData <- function(){
  return(data.frame(SeriesName = c("RPQTFHD","RPQB7YW"), DateFrom = c("31/Mar/1993","31/Mar/1993")))
}