allCombNames <- function(x, nPerComb){
  require(utils)
  namesX <- names(x)
  return( t(combn(namesX,nPerComb)) )
}