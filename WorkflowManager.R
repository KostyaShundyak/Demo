#This is a simple workflow manager
#Missing features in this implementation:
#1: logging
#2: batch run mode
#3: multi user mode
#4: metadata database (everything is kept in file names) 
#TBC

require(roxygen2)

source( file.path(getwd(),"R","sourceDir.R") )
sourceDir( file.path(getwd(),"R") )

#date of the run
runDate <- format(Sys.Date(),"%d/%b/%Y") 

#emulates generation of meta data for the FO system prior to the data trasfer from FO to HFS
Fo.meta.data <- generateFoMetaData()

#adds path (e.g. url) of data source to meta data in Hfs
#It is assumed that path becomes a unique identifier of the data source, i.e. sources on two
#different date have different paths
Fo.meta.data <- AddUrlToMetaData("BoE",as.Date("06/Aug/2015",format = "%d/%b/%Y"), Fo.meta.data)

#emulates initial data transfer
#Note, that FO system PULLs the required Fo.meta.data 
#and subsequently PUSHes all relevant portfolio data to HFS

FoToHfs(Fo.meta.data)

#todo: change dataset name to capture also source and dates

#emulates latest update of the data in Hadoop File system
#FoToHfs("BoE",Sys.Date(),Fo.meta.data)

#emulates load data from Hadoop in memory
hfsToInMemory("Hadoop.RData")

#emulates data reconciliation 
#WRITE FUNCTION

#emulates reporting data reconciliation results
#WRITE FUNCTION

#emulates data promotion approval form
#WRITE FUNCTION

#emulates data integration function. Conflict resolution is always performed 