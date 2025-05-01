list.of.packages <- c("Rcpp","tidyverse","ggplot2", ,
                      "MASS","rpart","glmnet","GGally","patchwork",
                      "data.table","readr","readxl","ggridge")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)


'%!in%' <- function(x,y)!('%in%'(x,y))

library(tidyverse)
library(patchwork)
library(ggplot2)
library(GGally)
library(ggridges)
library(plotly)

library(readr)
library(readxl)
library(data.table) #fread

library(MASS)
library(glmnet)

library(lubridate)
