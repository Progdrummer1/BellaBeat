#Join dActivity_both and sleepDay_no_duplicates
library(dplyr)

# dActivity_both$Id_Date <- c(dActivity_both$Id, dActivity_both$ActivityDate)
dActivity_both$Id_Date <- paste(dActivity_both$Id, dActivity_both$ActivityDate)
sleepDay_no_duplicates$Id_Date <- paste(sleepDay_no_duplicates$Id, sleepDay_no_duplicates$day)

merged_data <- dActivity_both %>% left_join(sleepDay_no_duplicates, by = "Id_Date")

shapiro.test(merged_data$SedentaryMinutes) #<-- #not normally distributed
shapiro.test(merged_data$Calories) #<-- #not normally distributed

cor.test(merged_data$TotalMinutesAsleep, merged_data$Calories, method = "spearman")
#p-value = 0.4366, rho -0.03852297 not significant

cor.test(merged_data$TotalMinutesAsleep, merged_data$SedentaryMinutes, method = "spearman")
p-value < 2.2e-16, rho, -0.5684106, Signifiant relation! 
There is a moderate negative relationship between these two variables.

#Export merged dataset, so it could be imported into Tableau. 
write.csv(merged_data, "...Capstone_Project_Bellabeat/R_Output/Merged_Data.csv", row.names = FALSE)
