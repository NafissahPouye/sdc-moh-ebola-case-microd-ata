library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/sdc-moh-ebola-case-microdata")
data <- read_excel("data.xlsx", sheet = "Master")

#Xchange Bangladesh microdata
selectedKeyVars <- c('StatusAsOfCurrentDate', 
                      'DateDeath','ParishRes',
                     'DistrictRes', 'Age', 
                      'Genre', 'VillageRes'
                     )
#weightVar <- c('weight')

#Convert variables into factors
cols =  c('StatusAsOfCurrentDate', 
          'Age', 'VillageRes',
          'Genre', 'DateDeath',
          'ParishRes', 'DistrictRes')
data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
fileRes<-data[,selectedKeyVars]
fileRes <- as.data.frame(fileRes)

#Assess the disclosure risk
objSDC <- createSdcObj(dat = fileRes, keyVars = selectedKeyVars)
print(objSDC, "risk")
report(objSDC, filename ="index",internal = T) 
