# Title   : Preprocess Korean to English
# Subject : Analyzing traffic accidents involving pedestrians using hierarchical model 
# Author : Seong-jong Woo

path <- paste0("E:/Severity/forGithub/R_template/")
rawPath <- paste0(path,"1_raw_data/")
analysisPath <- paste0(path,"3_analysis/r/")

source(paste0(analysisPath,"get_lib.R"))


# 1. population by age

popByAge <- fread(paste0(rawPath,"population_by_age_2016.csv"))

## Column 1. States
states <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q")
popByAge_State <- data.frame(ID = states, states = unique(popByAge$시도))

## Column 2. District
district <- 1:length(unique(popByAge$시군구))
popByAge_District <- data.frame(ID = district, district = unique(popByAge$시군구))

## Column 3. Delete
## Column 4. Age

popByAge_Age <- data.frame(ID = c("total","0~4","5~9","10~14","15~19","20~24","25~29","30~34","35~39","40~44","45~49","50~54","55~59","60~64","65~69","70~74","75~79","80~84","over_85","85~89","90~94","95~99","over_100","under_15","15~64","over_65","average","median"), age = (unique(popByAge$연령별)))

## Column 4.Contents

popByAge_contents <- data.frame(ID = c("total","male","female","gender_ratio","native_total","native_male","native_female","native_gender_ratio"), contents = (unique(popByAge$항목)))
