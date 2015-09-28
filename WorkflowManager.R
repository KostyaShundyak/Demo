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

#emulates initial data transfer on 06/Aug/2015
#Note, that FO system PUSHes all relevant portfolio data to HFS
#i.e. the FoToHfs has a state (metadata describing data to be pushed)

#FoToHfs("BoE",as.Date("06/Aug/2015",format = "%d/%b/%Y"))
FoToHfs("local",as.Date("06/Aug/2015",format = "%d/%b/%Y"),Fo.meta.data)

#todo: change dataset name to capture also source and dates

#emulates latest update of the data in Hadoop File system
FoToHfs("BoE",Sys.Date(),Fo.meta.data)

#emulates load data from Hadoop in memory
hfsToInMemory("Hadoop.RData")

#emulates data reconciliation 
#WRITE FUNCTION

#emulates reporting data reconciliation results
#WRITE FUNCTION

#emulates data promotion approval form
#WRITE FUNCTION

#emulates data integration function. Conflict resolution is always performed 