# Title   : Preprocess Korean to English
# Subject : Analyzing traffic accidents involving pedestrians using hierarchical model 
# Author : Seong-jong Woo

path <- paste0("E:/Severity/forGithub/R_template/")
rawPath <- paste0(path,"1_raw_data/")
analysisPath <- paste0(path,"3_analysis/r/")

source(paste0(analysisPath,"get_lib.R"))


# 1. population by age

popByAge <- fread(paste0(rawPath,"population_by_age_2016.csv"))

colnames(popByAge) <- c("states","district","delete","age","contents","2016")
popByAge <- popByAge[,-3]

## Column 1. States
states <- c("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q")
popByAge_State <- data.frame(ID = states, states = unique(popByAge$states))

for(i in 1:nrow(popByAge_State)){
  popByAge$states[(popByAge$states %in% popByAge_State$states[i])] <- popByAge_State$ID[i]
}

## Column 2. District
district <- 1:length(unique(popByAge$district))
popByAge_District <- data.frame(ID = district, district = unique(popByAge$district))

for(i in 1:nrow(popByAge_District)){
  popByAge$district[(popByAge$district %in% popByAge_District$district[i])] <- popByAge_District$ID[i]
}

## Column 3. Delete
## Column 4. Age

popByAge_Age <- data.frame(ID = c("total","0~4","5~9","10~14","15~19","20~24","25~29","30~34","35~39","40~44","45~49","50~54","55~59","60~64","65~69","70~74","75~79","80~84","over_85","85~89","90~94","95~99","over_100","under_15","15~64","over_65","average","median"), age = (unique(popByAge$age)))

for(i in 1:nrow(popByAge_Age)){
  popByAge$age[(popByAge$age %in% popByAge_Age$age[i])] <- popByAge_Age$ID[i]
}

## Column 4.Contents

popByAge_contents <- data.frame(ID = c("total","male","female","gender_ratio","native_total","native_male","native_female","native_gender_ratio"), contents = (unique(popByAge$contents)))

for(i in 1:nrow(popByAge_contents)){
  popByAge$contents[(popByAge$contents %in% popByAge_contents$contents[i])] <- popByAge_contents$ID[i]
}


#########################################################################################################################

# 2. road width

roadWidth <- fread(paste0(rawPath,"road_width_2016.csv"))

colnames(roadWidth) <- c("states","district","delete","total_length","over40m","25m_40m","12m_25m","under12m","ratio_under12m")
roadWidth <- roadWidth[,-3]

## Column 1. States
for(i in 1:nrow(popByAge_State)){
  roadWidth$states[(roadWidth$states %in% popByAge_State$states[i])] <- popByAge_State$ID[i]
}

## Column 2. District
for(i in 1:nrow(popByAge_District)){
  roadWidth$district[(roadWidth$district %in% popByAge_District$district[i])] <- popByAge_District$ID[i]
}

#########################################################################################################################

# 3. use district

useDistrict <- fread(paste0(rawPath,"use_district_2016_2020.csv"))

colnames(useDistrict) <- c("states","district","delete","type","contents","unit","2016","2017","2018","2019","2020")
useDistrict <- useDistrict[,-3]

## Column 1. States
for(i in 1:nrow(popByAge_State)){
  useDistrict$states[(useDistrict$states %in% popByAge_State$states[i])] <- popByAge_State$ID[i]
}

## Column 2. District
for(i in 1:nrow(popByAge_District)){
  useDistrict$district[(useDistrict$district %in% popByAge_District$district[i])] <- popByAge_District$ID[i]
}

