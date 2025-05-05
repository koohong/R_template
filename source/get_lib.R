list.of.packages <- c("Rcpp","tidyverse","patchwork","ggplot2","ggthemes" ,
                      "MASS","rpart","glmnet","GGally","patchwork",
                      "data.table","readr","readxl","pracma","far","odbc",
                      "RODBC","RSQLite","readxl",
                      "GGRidge",
                      "palmerpenguins","gt","kableExtra")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


'%!in%' <- function(x,y)!('%in%'(x,y))

#figures
library(tidyverse)
library(patchwork)
library(ggplot2)
library(GGally)
library(GGRidge)
library(plotly)
library(ggthemes)

#reading data
library(readr)
library(readxl)
library(data.table) #fread
library(kableExtra)

#connecting to DB
library(DBI)
library(dplyr)
library(dbplyr)

# library(dplyr.snowflakedb)
library(odbc)
library(RSQLite)
library(RODBC)

#model
library(MASS)
library(glmnet)

#time
library(lubridate)

#data
library(palmerpenguins)
library(gt)


