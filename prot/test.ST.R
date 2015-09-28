require(zoo)
require(xts)

#setwd("/Users/kostyashundyak/test")
#source("make.url.BOE.R")

#RPQTFHD: Quarterly amounts UK resident monetary financial institutions' sterling write-offs 
#of lending secured on dwellings to individuals (in sterling millions) not seasonally adjusted

#RPQTFHD.url <- make.url.BOE("RPQTFHD","31/Mar/1993","06/Aug/2015")
#RPQTFHD <- read.csv(RPQTFHD.url)
#write.csv(RPQTFHD,file = "/Users/kostyashundyak/Downloads/RPQTFHD.csv")

#RPQB7YW: Quarterly amounts outstanding UK resident banks and building societies sterling net 
#secured lending to individuals (in sterling millions) not seasonally adjusted

#RPQB7YW.url <- make.url.BOE("RPQB7YW","31/Mar/1993","06/Aug/2015")
#RPQB7YW <- read.csv(RPQB7YW.url)
#write.csv(RPQB7YW,file = "/Users/kostyashundyak/Downloads/RPQB7YW.csv")

RPQTFHD[["annualWO"]] <- rollapply(RPQTFHD$RPQTFHD,4,sum,align="left",fill="extend")
BOEMortgages <- merge(RPQTFHD,RPQB7YW,by.x="DATE",by.y="DATE",all=TRUE,sort=FALSE)

BOEMortgages[["annualLossRate"]] <- BOEMortgages$annualWO / BOEMortgages$RPQB7YW
LGD <- 0.3
BOEMortgages[["DR"]] <- BOEMortgages$annualLossRate / LGD
BOEMortgages[["LOGIT_DR"]] <- log ( BOEMortgages$DR / (1 - BOEMortgages$DR) )
BOEMortgages[["DATE"]] <- as.Date(BOEMortgages$DATE,format="%d %b %Y")
BOEMortgages <- xts(BOEMortgages[,-1],order.by = BOEMortgages$DATE, tz = 'GMT')
#--------------------------------

require(stringr)
require(XLConnect)
baseHTTP <- 'http://www.bankofengland.co.uk/financialstability/Documents/stresstesting/2015/variablepaths2015.xlsx'
wb = loadWorkbook("/Users/kostyashundyak/test/demo/data/variablepaths2015.xlsx")
bMEV = readWorksheet(wb, sheet = "Macroeconomic variables (b) ", header = TRUE)

which.na.col.bMEV <- which(sapply(1:ncol(bMEV), function(i) all(is.na(bMEV[[i]]))))
names.col.bMEV <- gsub("...of.which.","",names(bMEV),fixed = TRUE)
which.names.nonCol.bMEV <- which( substr(names.col.bMEV,1,3) != "Col" )
which.names.upCol.bMEV <- sapply(1:3, function(i) min( which.na.col.bMEV[which.names.nonCol.bMEV[i] < which.na.col.bMEV] ))-1

bMEV[1,] <- gsub("-","", bMEV[1,], fixed = TRUE)
bMEV[1,] <- gsub("  "," ", bMEV[1,], fixed = TRUE)
bMEV[1,] <- gsub(" ",".", bMEV[1,], fixed = TRUE)

for (i in 1:length(which.names.nonCol.bMEV) ){
  intrvl <- which.names.nonCol.bMEV[i] : which.names.upCol.bMEV[i]
  bMEV[1,intrvl] <- paste(names.col.bMEV[intrvl[1]], bMEV[1,intrvl],sep=".")
}
bMEV <- bMEV[,-which.na.col.bMEV]
remove(intrvl)
remove(which.names.nonCol.bMEV)
remove(which.names.upCol.bMEV)
remove(which.na.col.bMEV)
remove(names.col.bMEV)

bMEV[1,1] <- "DATE"
names(bMEV) <-bMEV[1,]

hRow <- which(bMEV[,1] == "Historical data") + 1
pRow <- which(bMEV[,1] == "Projections") + 1

histBaseMEV <- (bMEV[hRow:(pRow-2),])
histBaseMEV <- na.locf(histBaseMEV,fromLast = TRUE)
rownames(histBaseMEV) <-NULL
for( i in which(!(names(histBaseMEV) == "DATE")) ){ histBaseMEV[,i] <- as.numeric(histBaseMEV[,i])}
histBaseMEV[["DATE"]] <- as.Date(as.yearqtr(histBaseMEV[["DATE"]],format="Q%q %Y"),frac = 1)
histBaseMEV <- xts(histBaseMEV[,-1],order.by = histBaseMEV$DATE, tz = 'GMT')

projBaseMEV <- (bMEV[pRow:nrow(bMEV),])
projBaseMEV <- na.locf(projBaseMEV,fromLast = TRUE)
rownames(projBaseMEV) <-NULL
for( i in which(!(names(projBaseMEV) == "DATE")) ){ projBaseMEV[,i] <- as.numeric(projBaseMEV[,i])}
projBaseMEV[["DATE"]] <- as.Date(as.yearqtr(projBaseMEV[["DATE"]],format="Q%q %Y"),frac = 1)
projBaseMEV <- xts(projBaseMEV[,-1],order.by = projBaseMEV$DATE, tz = 'GMT')

remove(hRow, pRow)
remove(bMEV)

#--------------------------------

source("./prot/univariate.R")
univHistBaseMEV <- univariate(histBaseMEV)
univprojBaseMEV <- univariate(projBaseMEV)
corHistBaseMEV <- cor(histBaseMEV[,-1])
heatmap(corHistBaseMEV)

#--------------------------------
source("./prot/modelStackExplorer.R")

regrDataWithNA <- merge(BOEMortgages[,c(6)],histBaseMEV[,c(1:18)])
regrData <- make.index.unique(regrDataWithNA[complete.cases(regrDataWithNA)])
indexClass(regrData) <- c("POSIXt", "POSIXct")

modelStack <- modelStackExplorer(regrData[,1],regrData[,c(2:19)],nVars=2)

#--------------------------------


#varStr <- "UK.real.GDP + UK.CPI + UK.unemployment.rate"
#fit <- lm(LOGIT_DR ~ ., data=regrData[,-1])
#summary(fit)

# Other useful functions 
#regrCoef <- coefficients(fit) # model coefficients
#regrConfInt <- confint(fit, level=0.95) # CIs for model parameters 
#regrFitted <- fitted(fit) # predicted values
#regrRes <- residuals(fit) # residuals
#regrAnova <- anova(fit) # anova table 
#regrVCov <- vcov(fit) # covariance matrix for model parameters 
#regrInfl <- influence(fit) # regression diagnostics

# diagnostic plots 
#layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
#plot(fit)



