12-12-24  
	**Daily activity files**

* **Merged dActivity** (dailyActivity\_merged from March/April) and **dActivity2** (dailyActivity\_merged2 from March/April) to **dActivity\_both**.   
* Changed date type from ‘character’ to ‘date’ in **dActivity\_both**.   
* Removed the records from **dActivity** with the date 4/12/2016, since it is duplicated with dataset **dActivity2** (overlapping).   
* Removed rows with only 0 values.  
* Removed rows with SedentaryMinutes \= 1440, which is 24 hours, because it is repeated many times and correlates with different types of results. For example 10330 steps, but also 0 steps.  
    
  **Sleep files**  
* Removed the times from **SleepDay**, to only keep the date  
* Changed data type of **SleepDay** from ‘character’ to ‘date’.   
* Removed the 3 duplicates from sleepDay.  
* Renamed column “SleepDay” to “Day”, to avoid ambiguity. 

# Calculations 

**Activity data**  
Means:  
\# TotalSteps: 			7377.375  
\# TotalDistance		5.289031  
\# TrackerDistance: 		5.261930  
\# LoggedActivitiesDistance: 	0.1285915  
\# VeryActiveDistance: 	1.413146  
\# ModeratelyActiveDistance: 	0.5460524  
\# LightActiveDistance: 	3.238128  
\# SedentaryActiveDistance: 	0.00173343  
\# VeryActiveMinutes: 		19.87109  
\# FairlyActiveMinutes: 	13.60379  
\# LightlyActiveMinutes: 	188.0961  
\# SedentaryMinutes: 		1001.347  
\# Calories: 			2294.812

Spearman’s correlation  
                           Calories  
TotalSteps                **0.55498072,  p \< 2.2e-16**  
TotalDistance             **0.60670775   p \< 2.2e-16**  
TrackerDistance           0.60448207  
LoggedActivitiesDistance  0.21023202  
VeryActiveDistance        0.48169250  
ModeratelyActiveDistance  0.41462640  
LightActiveDistance       0.45754946  
SedentaryActiveDistance   0.01603382  
VeryActiveMinutes         **0.52195367   p \< 2.2e-16**  
FairlyActiveMinutes       0.44870631  
LightlyActiveMinutes      0.30591874  
SedentaryMinutes         \-0.17946518

cor.test(dActivity\_both$Calories, dActivity\_both$TotalSteps )  
\# t \= 26.368, df \= 1371, p-value \< 2.2e-16  
cor.test(dActivity\_both$Calories, dActivity\_both$TotalDistance)  
\# t \= 30.005, df \= 1371, p-value \< 2.2e-16  
cor.test(dActivity\_both$Calories, dActivity\_both$VeryActiveDistance)  
\# t \= 20.273, df \= 1371, p-value \< 2.2e-16  
cor.test(dActivity\_both$Calories, dActivity\_both$VeryActiveMinutes)  
\# t \= 27.328, df \= 1371, p-value \< 2.2e-16

                            Calories  
Id                       0.000000e+00  
TotalSteps               0.000000e+00  
TotalDistance            0.000000e+00  
TrackerDistance          0.000000e+00  
LoggedActivitiesDistance 6.732392e-13  
VeryActiveDistance       0.000000e+00  
ModeratelyActiveDistance 0.000000e+00  
LightActiveDistance      0.000000e+00  
SedentaryActiveDistance  3.427846e-02  
VeryActiveMinutes        0.000000e+00  
FairlyActiveMinutes      0.000000e+00  
LightlyActiveMinutes     0.000000e+00  
SedentaryMinutes         2.021466e-06  
Calories                           NA

# **Sleep data**

\> mean(sleepDay\_no\_duplicates$TotalMinutesAsleep)  
\[1\] 419.1732

\# shapiro.test(sleepDay$TotalMinutesAsleep)  
\# Shapiro-Wilk normality test  
\# data:  sleepDay$TotalMinutesAsleep  
\# W \= 0.95117, p-value \= 1.923e-10  
\# p \<0.05 dus de nul hypthese dat deze data normaal verdeeld is, wordt verworpen. 

**Merged**  
**Non-parametric testing**

cor.test(merged\_data$TotalMinutesAsleep, merged\_data$SedentaryMinutes, method \= "spearman")  
\#p-value \< 2.2e-16, rho, \-0.5684106, Signifiant relation\!   
\# There is a moderate negative relationship between these two variables, and the result is statistically significant. In other words, the data provides strong evidence that more sleep is associated with less sedentary time (or vice versa).

cor.test(merged\_data$TotalMinutesAsleep, merged\_data$Calories, method \= "spearman")  
\#p-value \= 0.4366, rho \-0.03852297 not significant

