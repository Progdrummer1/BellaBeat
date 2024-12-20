#install.packages("dplyr")
library(dplyr)

#Importing data
sleepDay <- read.csv(".../Capstone_Project_Bellabeat/Data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/sleepDay_merged.csv")

#renaming ambigue column name
sleepDay <-sleepDay %>%
  rename(day=SleepDay)

#checking for any duplicates with id and day columns combinations. 
sum(duplicated(sleepDay[, c("day", "Id")]))
#3, 
#so there are three id's which have two dates. 

# Find the duplicated rows based on 'day' and 'Id'
sleep_duplicates <- sleepDay[duplicated(sleepDay[, c("day", "Id")]), ]

# Viewing the duplicated records, they all contain exactly the same values, so the duplicates have to be removed
library(dplyr)
sleepDay_no_duplicates <- sleepDay %>%
  distinct(day, Id, .keep_all = TRUE)

#checking max values
sleepDay_max_values <- apply(sleepDay_no_duplicates, 2, max)
print(sleepDay_max_values)
# Id                       day                        TotalSleepRecords     TotalMinutesAsleep 
# "8792009665"      "5/9/2016 12:00:00 AM"                       "3"                  "796" 
# TotalTimeInBed 
#     "961"

#these all seem reasonable results within the realistic limit of each variable, although 16 hours spend in bed is a bit long, maybe someone was sick. 


#checking min values
sleepDay_min_values <- apply(sleepDay_no_duplicates, 2, min)
print(sleepDay_min_values)
# Id                SleepDay                       TotalSleepRecords      TotalMinutesAsleep          TotalTimeInBed 
# "1503960366"    "4/12/2016 12:00:00 AM"                  "1"                   " 58"                   " 61"
#61 minutes in bed is short, but possible as the minimum. 

#Checking data types
sleepDay_data_types <- sapply(sleepDay_no_duplicates, class)
print(sleepDay_data_types)
# Id                SleepDay        TotalSleepRecords   TotalMinutesAsleep     TotalTimeInBed 
# "numeric"        "character"          "integer"          "integer"             "integer"
#SleepDay now has the date and the time of the start of the day, while it should only contain the date itself. 

#keep only the dates, not the times
sleepDay_no_duplicates$day <- substr(sleepDay_no_duplicates$day, 1, 10)

#also it is a "Character" data type instead of "Date". 
#Change to "Date"
sleepDay_no_duplicates$day <- as.Date(sleepDay_no_duplicates$day, format = "%m/%d/%Y")
sleepDay_no_duplicates_data_types <- sapply(sleepDay_no_duplicates, class)
print(sleepDay_no_duplicates_data_types)

#any empty values?
any(is.na(sleepDay_no_duplicates))
#False

#any null values?
any(is.null(sleepDay_no_duplicates))
#False

skim_without_charts(sleepDay_no_duplicates$Id)
mean(sleepDay_no_duplicates$TotalMinutesAsleep)

table(sleepDay_no_duplicates$Id)

#31, 31, 31, 28, 28, 28, 27, 26, 26, 25, 24, 23, 18, 15, 15, 8, 5, 5, 4, 3, 3, 3, 2, 1
#total 410 observations 

# Shapiro-Wilk test for normality
shapiro.test(sleepDay$TotalMinutesAsleep)
# p-value = 1.923e-10
# p <0.05, therefore not normally distributed.  
