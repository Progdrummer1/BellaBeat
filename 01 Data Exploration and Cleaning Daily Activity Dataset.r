#install.packages("skimr")
library(skimr)
#install.packages("janitor")
library(janitor)

#import Daily activity data sets
dActivity<- read.csv(".../Capstone_Project_Bellabeat/Data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/dailyActivity_merged.csv")
dActivity2 <- read.csv(".../Capstone_Project_Bellabeat/Data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/dailyActivity_merged.csv")


#Removing overlapping date
dActivity <- dActivity[dActivity$ActivityDate != "4/12/2016", ]


#Merging the tables from March/April and April/May together
dActivity_both <- rbind(dActivity, dActivity2)


#Checking for reliability 
View(dActivity_both)
#Turns out sometimes there are days where there was no input and this has be interpreted as 0 on every variable. 

 
#checking for any duplicates with id and ActivityDate columns combinations. 
sum(duplicated(dActivity_both[, c("ActivityDate", "Id")]))
#24 before removing them!!
#these duplicates sneaked in here because it is the end of the first data set and the start of the second!

#Checking max values per column 
dActivity_both_max_values <- apply(dActivity_both, 2, max)
print(dActivity_both_max_values)

#Id                        ActivityDate               TotalSteps 
#"8877689391"              "5/9/2016"                 "36019" 
#TotalDistance            TrackerDistance Logged      ActivitiesDistance 
#"28.03"                  "28.03"                     "4.942142" 
#VeryActiveDistance       ModeratelyActiveDistance     LightActiveDistance 
#"21.92"                  "6.48"                      "10.71" 
#SedentaryActiveDistance  VeryActiveMinutes            FairlyActiveMinutes 
#"0.11"                   "210"                       "143" 
#LightlyActiveMinutes     SedentaryMinutes            Calories 
#"518"                    "1440"                      "4900" 

#these all seem reasonable results within the realistic limit of each variable. 

#Checking min values per column
dActivity_both_min_values <- apply(dActivity_both, 2, min)
print(dActivity_both_min_values)
# Id                        ActivityDate               TotalSteps 
# "1503960366"              "2016-03-12"              "    0" 
# TotalDistance             TrackerDistance           LoggedActivitiesDistance 
# " 0.00"                   " 0.00"                  "0.000000" 
# VeryActiveDistance        ModeratelyActiveDistance   LightActiveDistance 
# " 0.00"                   "0.00"                    " 0.00" 
# SedentaryActiveDistance    VeryActiveMinutes    FairlyActiveMinutes 
# "0.00"                    "  0"                     "  0" 
# LightlyActiveMinutes      SedentaryMinutes       Calories 
# "  0"                     "   0"                      "   0" 
#some 0 values need to be evaluated, since no one burns 0 calories per day. 


#checking data types
dActivity_both_data_types <- sapply(dActivity_both, class)
print(dActivity_both_data_types)
#Id                       ActivityDate                     TotalSteps 
#"double"                 "character"                      "integer" 
#TotalDistance            TrackerDistance LoggedActivities  Distance 
#"double"                 "double"                         "double" 
#VeryActiveDistance       ModeratelyActiveDistance          LightActiveDistance 
#"double"                 "double"                         "double" 
#SedentaryActiveDistance  VeryActiveMinutes                FairlyActiveMinutes 
#"double"                 "integer"                        "integer" 
#LightlyActiveMinutes     SedentaryMinutes                  Calories 
#"integer"                "integer"                         "integer" 
#transform ActivityDate into Date 

#Changing to date data type
dActivity_both$ActivityDate <- as.Date(dActivity_both$ActivityDate, format = "%m/%d/%Y")
dActivity_both_data_types <- sapply(dActivity_both, class)
print(dActivity_both_data_types)

#Id                       ActivityDate                     TotalSteps 
#"double"                 "Date"                      "integer" 
#TotalDistance            TrackerDistance LoggedActivities  Distance 
#"double"                 "double"                         "double" 
#VeryActiveDistance       ModeratelyActiveDistance          LightActiveDistance 
#"double"                 "double"                         "double" 
#SedentaryActiveDistance  VeryActiveMinutes                FairlyActiveMinutes 
#"double"                 "integer"                        "integer" 
#LightlyActiveMinutes     SedentaryMinutes                  Calories 
#"integer"                "integer"                         "integer" 
#transform ActivityDate into Date 

#check if all dates values have the same length. 
length_check <- sapply(dActivity_both$ActivityDate, nchar)
all(length_check == length_check[1]) # TRUE

library(dplyr)

#any empty values?
any(is.na(dActivity_both))
#False

#any null values?
any(is.null(dActivity_both))
#false

dActivity_both <- dActivity_both %>% 
    filter(SedentaryMinutes != 1440)

skim_without_charts(dActivity_both)
