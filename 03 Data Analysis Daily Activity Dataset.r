#Calculating the means of every column
numeric_df <- dActivity_both[sapply(dActivity_both, is.numeric)]
col_means <- colMeans(numeric_df, na.rm = TRUE)
print(numeric_df)
rm(numeric_df)
# Id: 4782326000
# TotalSteps: 7377.375
# TotalDistance: 5.289031
# TrackerDistance: 5.261930
# LoggedActivitiesDistance: 0.1285915
# VeryActiveDistance: 1.413146
# ModeratelyActiveDistance: 0.5460524
# LightActiveDistance: 3.238128
# SedentaryActiveDistance: 0.00173343
# VeryActiveMinutes: 19.87109
# FairlyActiveMinutes: 13.60379
# LightlyActiveMinutes: 188.0961
# SedentaryMinutes: 1001.347
# Calories: 2294.812


shapiro.test(merged_data$SedentaryMinutes) #<-- #not normally distributed
shapiro.test(merged_data$Calories) #<-- #not normally distributed

#calculating the Spearman's correlation between the variable 'calories' and other variables. 
numeric_df <- dActivity_both[sapply(dActivity_both, is.numeric)]
cor_matrix <- cor(numeric_df, method = "spearman", use = "complete.obs")
print(cor_matrix)
# rm(numeric_df)

#Testing significance of highest correlations 
cor.test(dActivity_both$TotalSteps,dActivity_both$Calories, method = "spearman")
#p-value < 2.2e-16, highly significant
#cor 0.58, moderate relation

cor.test(dActivity_both$SedentaryMinutes,dActivity_both$Calories)
#cor -0.1278156, small negative relation
#p-value = 2.021e-06, highly significant

cor.test(dActivity_both$TotalSteps ,dActivity_both$Calories)
# p  = 2.2e-16, highly significant
# cor = 0.6295828,
# Correlation between total steps and calories is highly significant, and modeartely positive


