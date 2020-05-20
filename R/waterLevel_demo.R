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



