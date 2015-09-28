#' Function creating a stack of models with the highest performance metrics (e.g. adjusted R2)
#'
#' @param DV a dependent variable (xts class)
#' @param IVs independent variables (xts class)
#' @param nMaxModels maximum number of models stored in the model stack
#' @param nVars maximum number of MEVs in the model
#' @param Lmax maximum lag per MEV considered in the model 
#'
#' @return a list containing a model stack and corresponding dictionaries
#' @export
#'
#' @examples
modelStackExplorer <- function(DV, IVs, nMaxModels=100, nVars=1, Lmax=4){
  
  source("./prot/allCombNames.R")
  
  #required for the lagged regression
  require(dynlm)
  
  #required for arrange function
  require(dplyr)
  
  #a matrix containing all combinations of names of IVs
  combNamesIVs <- allCombNames(IVs,nVars)
  
  #a number of IVs combinations
  nCombNamesIVs <- dim(combNamesIVs)[1]
  
  #an empty data.frame containing indices of the selected model IVs and lags 
  modelStack <- data.frame( adjR2 = numeric(nMaxModels), iModel = numeric(nMaxModels), iLag = numeric(nMaxModels)) 
  
  #a 1D vector of modelled lags (e.g 0,1,2,3,4)
  Lvec <- 0:Lmax
  
  #a data.frame of all modelled lags
  lags <- expand.grid(replicate(3, Lvec, simplify=FALSE))
  
  #a number of modelled lags
  nLags <- dim(lags)[1]
  
  #combined DV-IVs xts object
  DV_IVs <- merge(DV,IVs)
  
  #loop over all combinations of IVs
  for (iCombNamesIVs in 1:nCombNamesIVs){
    #loop over all lags
    for(iLag in 1:nLags){ 
      
      laggedVars <- sapply(1:nVars, function(iLaggedVar) paste("L(", combNamesIVs[iCombNamesIVs,iLaggedVar],",",lags[iLag,iLaggedVar],")"))
      model_ <- paste( "LOGIT_DR ~", paste( laggedVars, collapse=" + ") )
      
      #fit the model
      fit <- dynlm( as.formula(model_), DV_IVs )
      
      #summarise the statistical properties of the fit
      smr <- summary(fit)
      
      #model performance metric
      adjR2_ <- smr$adj.r.squared
      
      #stack update
      if(adjR2_ > modelStack[nMaxModels,]$adjR2){
        modelStack[nMaxModels,] <- c(adjR2_,iCombNamesIVs,iLag)
        modelStack <- arrange(modelStack, desc(adjR2))
      }
    }
  }
  return(list(modelStack=modelStack, combNamesIVs = combNamesIVs, lags = lags))
}