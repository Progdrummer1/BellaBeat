#Join dActivity_both and sleepDay_no_duplicates
library(dplyr)

# dActivity_both$Id_Date <- c(dActivity_both$Id, dActivity_both$ActivityDate)
dActivity_both$Id_Date <- paste(dActivity_both$Id, dActivity_both$ActivityDate)
sleepDay_no_duplicates$Id_Date <- paste(sleepDay_no_duplicates$Id, sleepDay_no_duplicates$day)

merged_data <- dActivity_both %>% left_join(sleepDay_no_duplicates, by = "Id_Date")
