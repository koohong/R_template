# Title   : Preprocess Korean to English
# Subject : Analyzing traffic accidents involving pedestrians using hierarchical model 
# Author : Seong-jong Woo

path <- paste0("E:/Severity/forGithub/R_template/")
rawPath <- paste0(path,"1_raw_data/")
analysisPath <- paste0(path,"3_analysis/r/")

source(paste0(analysisPath,"get_lib.R"))

options(scipen = 100)

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

# 5. pedestrian accident


pedestrianAccident <- fread(paste0(rawPath,"accident_2016_2020.csv"))
pedestrianAccident <- pedestrianAccident[-which(pedestrianAccident$사고유형_대분류 %in% c("차대차","차량단독")),]

# pedestrianAccident[pedestrianAccident$사고유형_대분류 %in% c("차대차","차량단독"),]
colnames(pedestrianAccident) <- c("ID","date","time","day","day_or_night","states","delete1", "district","delete2","accident_type","violation","drunken","alcochol_degree","perpetrator_sex","perpetrator_age","vehicle_type","victim_sex","victim_age","severity","road_type","road_shape","road_alignment","junction_shape","road_surface","road_surface_condition","weather")
pedestrianAccident <- pedestrianAccident[,!c("delete1","delete2")]

## Column 4. day
pedestrianAccident_day <- data.frame(DayEng = c("Fri","Sat","Sun","Mon","Tue","Wed","Thu"), DayKor = (unique(pedestrianAccident$day)))

for(i in 1:nrow(pedestrianAccident_day)){
  pedestrianAccident$day[(pedestrianAccident$day %in% pedestrianAccident_day$DayKor[i])] <- pedestrianAccident_day$DayEng[i]
}

## Column 5. day_or_night
pedestrianAccident_dayOrNight <- data.frame(dayOrNightEng = c("day","night"), dayOrNightKor = (unique(pedestrianAccident$day_or_night)))

for(i in 1:nrow(pedestrianAccident_dayOrNight)){
  pedestrianAccident$day_or_night[(pedestrianAccident$day_or_night %in% pedestrianAccident_dayOrNight$dayOrNightKor[i])] <- pedestrianAccident_dayOrNight$dayOrNightEng[i]
}

## Column 6. States
for(i in 1:nrow(popByAge_State)){
  pedestrianAccident$states[(pedestrianAccident$states %in% popByAge_State$states[i])] <- popByAge_State$ID[i]
}

## Column 7. District
for(i in 1:nrow(popByAge_District)){
  pedestrianAccident$district[(pedestrianAccident$district %in% popByAge_District$district[i])] <- popByAge_District$ID[i]
}

## Column 8. accident type
pedestrianAccident_accType <- data.frame(accTypeEng = c("roadway","etc","crosswalk","roadside_area","sidewalk"), accTypeKor = (unique(pedestrianAccident$accident_type)))

for(i in 1:nrow(pedestrianAccident_accType)){
  pedestrianAccident$accident_type[(pedestrianAccident$accident_type %in% pedestrianAccident_accType$accTypeKor[i])] <- pedestrianAccident_accType$accTypeEng[i]
}

## Column 9. violation
pedestrianAccident_violation <- data.frame(violationEng = c("violation_of_safe-driving","etc","driving_over_the_median_lane","violation_of_traffic_signals","violation_of_protection_of_pedestrian","violation_of_passing_through_intersections","violation_of_restrictions_on_speed","violation_of_safe_distance"), violationKor = (unique(pedestrianAccident$violation)))

for(i in 1:nrow(pedestrianAccident_violation)){
  pedestrianAccident$violation[(pedestrianAccident$violation %in% pedestrianAccident_violation$violationKor[i])] <- pedestrianAccident_violation$violationEng[i]
}

## Column 10. perpetrator_sex
pedestrianAccident_perpSex <- data.frame(perpSexEng = c("male","female","unidentified"), perpSexKor = (unique(pedestrianAccident$perpetrator_sex)))

for(i in 1:nrow(pedestrianAccident_perpSex)){
  pedestrianAccident$perpetrator_sex[(pedestrianAccident$perpetrator_sex %in% pedestrianAccident_perpSex$perpSexKor[i])] <- pedestrianAccident_perpSex$perpSexEng[i]
}

## Column 11. perpetrator_age
pedestrianAccident$perpetrator_age[(pedestrianAccident$perpetrator_age %in% "불명")] <- "unidentified"

## Column 12. vehicle type
pedestrianAccident_vihicle <- data.frame(vehicleEng = c("automobile","truck","special-purpose_vehicle","bus","etc/unidentified","motorcycles","two-wheeled_vehicle","bicycles","construction_machinery","agricultural_machine","all-terrain_vehicle","personal_mobility_device"), vehicleKor = (unique(pedestrianAccident$vehicle_type)))

for(i in 1:nrow(pedestrianAccident_vihicle)){
  pedestrianAccident$vehicle_type[(pedestrianAccident$vehicle_type %in% pedestrianAccident_vihicle$vehicleKor[i])] <- pedestrianAccident_vihicle$vehicleEng[i]
}



