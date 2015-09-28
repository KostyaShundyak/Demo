univariate <- function(x){
  xclass <- sapply(1:ncol(x), function(i) class( x[[i]] ))
  xnames <- names(x)
  xsummary <- {}
  for (i in which(xclass == "numeric")){
    cur <- c( xnames[i], min(x[[i]],na.rm=TRUE), mean(x[[i]],na.rm=TRUE), max(x[[i]],na.rm=TRUE) )
    cur <- setNames(cur,c("Name","Min","Mean","Max"))
    
    qtls <- quantile( x[[i]], na.rm=TRUE, probs = 1:9/10 )
    setNames(qtls,paste("q",names(qtls),sep=""))
    cur <- c(cur,qtls)
    
    cur <- c(cur, setNames(sd(x[[i]],na.rm=TRUE),"Stdev"))
    
    xsummary <- rbind(xsummary, cur)
  }
  rownames(xsummary) <- NULL
  return(xsummary)
}