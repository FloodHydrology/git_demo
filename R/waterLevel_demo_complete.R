#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Title: Water Level Demo
#Coder: Nate Jones
#Date: 5/20/2020
#Purpose: Demo Water Level Processing
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Step 1: Setup workspace--------------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Clear memory
remove(list=ls())

#install relevant packages
# install.packages('tidyverse')
# install.packages('lubridate')
# install.packages('xts')
# install.packages('dygraph')
# install.packages("htmlwidgets")

#Load libraries of interest
library(tidyverse)
library(lubridate)
library(xts)
library(dygraphs)
library(htmlwidgets)

#Download data
wetland<-read_csv('data/wetland.csv')
baro<-read_csv('data/baro.csv')

#Clean up tibbles
wetland<-wetland %>% 
  mutate(Timestamp = as.POSIXct(Timestamp, format = "%m/%d/%Y %H:%M"))

baro<-baro %>% 
  mutate(Timestamp = as.POSIXct(Timestamp, format = "%m/%d/%Y %H:%M"))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Step 2: Estimate water level---------------------------------------------------
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Create function to interpolate baro data
baro<-na.omit(baro)
baro_fun<-approxfun(baro$Timestamp, baro$press_kPa)

#Add baro pressure to wetland
df<-wetland %>% 
  #Interpolate atm pressure
  mutate(p_atm = baro_fun(Timestamp)) %>% 
  #Estimate water pressure
  mutate(p_h20 = press_kPa - p_atm) %>% 
  #Estimate pressure head
  mutate(waterDepth = p_h20/9.81)

#Create dygraph
#format data
df_xts<-df %>% select(Timestamp, waterDepth)
df_xts<-xts(df_xts, order.by=df$Timestamp)
df_xts<-df_xts[,-1]

#Dygraph
h<-dygraph(df_xts) %>%
  dyRangeSelector() %>%
  dyLegend() %>%
  dyOptions(strokeWidth = 1.5) %>%
  dyOptions(labelsUTC = TRUE) %>%
  dyHighlight(highlightCircleSize = 5,
              highlightSeriesBackgroundAlpha = 0.2,
              hideOnMouseOut = FALSE) %>%
  dyAxis("y", label = "Variable") 

saveWidget(h, file="hydrograph.html")
  
