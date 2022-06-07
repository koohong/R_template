# Title   : Preprocess Korean to English
# Subject : Analyzing traffic accidents involving pedestrians using hierarchical model 
# Author : Seong-jong Woo

path <- paste0("E:/Severity/forGithub/R_template/")
rawPath <- paste0(path,"1_raw_data/")
analysisPath <- paste0(path,"3_analysis/r/")

source(paste0(analysisPath,"get_lib.R"))


# 1. population by age

popByAge <- fread(paste0(rawPath,"population_by_age_2016.csv"))

colnames(popByAge) <- c("states","delete","district","age","contents","2016")
popByAge <- popByAge[,-2]


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

colnames(roadWidth) <- c("states","delete","district","total_length","over40m","25m_40m","12m_25m","under12m","ratio_under12m")
roadWidth <- roadWidth[,-2]

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

colnames(useDistrict) <- c("states","delete","district","type","contents","unit","2016","2017","2018","2019","2020")
useDistrict <- useDistrict[,-2]

## Column 1. States
for(i in 1:nrow(popByAge_State)){
  useDistrict$states[(useDistrict$states %in% popByAge_State$states[i])] <- popByAge_State$ID[i]
}

## Column 2. District
for(i in 1:nrow(popByAge_District)){
  useDistrict$district[(useDistrict$district %in% popByAge_District$district[i])] <- popByAge_District$ID[i]
}

## Column 4.type

useDistrict_Type <- data.frame(ID = c("total_zone","zone1","zone11","zone12","zone13","zone14","zone15","zone16","zone17","zone18","zone2","zone21","zone22","zone23","zone24","zone3","zone31","zone32","zone33","zone4","zone41","zone42","zone43","zone5"), TypeEng = c("urban_area","residential_area","total_exclusive_residential_area","class1_exclusive_residential_area","class2_exclusive_residential_area","total_general_residential_area","class1_general_residential_area","class2_general_residential_area","class3_general_residential_area","quasi_residential_area","commercial_area","central_commercial_area","general_commercial_area","neighboring_commercial_area","circulative_commercial_area","industrial_area","exclusive_industrial_area","general_industrial_area","quasi_industrial_area","green_area","green_conservation_area","green_natural_area","green_production_area","not_clssified_area"), TypeKor = (unique(useDistrict$type)))

for(i in 1:nrow(useDistrict_Type)){
  useDistrict$type[(useDistrict$type %in% useDistrict_Type$TypeKor[i])] <- useDistrict_Type$ID[i]
}

## Column 5.contents

useDistrict$contents[(useDistrict$contents %in% "면적")] <- "area"
useDistrict$contents[(useDistrict$contents %in% "비율")] <- "ratio"



#########################################################################################################################

# 4. emergency medical institution

emergencyMedical <- fread(paste0(rawPath,"emergency_medical_2016-rvsd.csv"))

colnames(emergencyMedical) <- c("delete1","code","delete2","delete3","medical_institution_type","emergency_medical_institution_type","delete6", "delete4","states","delete5","district","x_cordinate","y_cordinate")
emergencyMedical <- emergencyMedical[,!c("delete1","delete2","delete3","delete4","delete5","delete6")]

## Column 2. medical institution type
emergencyMedical_type1 <- data.frame(Type1Eng = c("tertiary_hospital","general_hospital","hospital","public_health_clinic","military_hospital"), Type1Kor = (unique(emergencyMedical$medical_institution_type)))

for(i in 1:nrow(emergencyMedical_type1)){
  emergencyMedical$medical_institution_type[(emergencyMedical$medical_institution_type %in% emergencyMedical_type1$Type1Kor[i])] <- emergencyMedical_type1$Type1Eng[i]
}

## Column 3. emergency institution type
emergencyMedical_type2 <- data.frame(Type2Eng = c("regional_emergency_medical_center","specialized_emergency_medical_center","local_emergency_medical_center","local_emergency_medical_institution"), Type2Kor = (unique(emergencyMedical$emergency_medical_institution_type)))

for(i in 1:nrow(emergencyMedical_type2)){
  emergencyMedical$emergency_medical_institution_type[(emergencyMedical$emergency_medical_institution_type %in% emergencyMedical_type2$Type2Kor[i])] <- emergencyMedical_type2$Type2Eng[i]
}

## Column 4. States
for(i in 1:nrow(popByAge_State)){
  emergencyMedical$states[(emergencyMedical$states %in% popByAge_State$states[i])] <- popByAge_State$ID[i]
}

## Column 2. District
for(i in 1:nrow(popByAge_District)){
  emergencyMedical$district[(emergencyMedical$district %in% popByAge_District$district[i])] <- popByAge_District$ID[i]
}

#########################################################################################################################

# 5. emergency medical institution

