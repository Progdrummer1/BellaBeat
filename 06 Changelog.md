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
