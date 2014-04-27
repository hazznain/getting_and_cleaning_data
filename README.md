Getting and cleaning_data
=========================

For the course assignment of John Hopkin University course "Getting and Cleaning Data" on coursera

## Task:
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

link of the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

*create one R script called run_analysis.R that does the following. 
*Merges the training and the test sets to create one data set.
*Extracts only the measurements on the mean and standard deviation for each measurement. 
*Uses descriptive activity names to name the activities in the data set
*Appropriately labels the data set with descriptive activity names. 
*Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Running the script:

1.  clone this repo using following in gitbash / terminal.   

	`git clone https://github.com/hazznain/getting_and_cleaning_data.git`
	
2.	Download the data using following link into cloned repo directory and uncompress it within that directory so that "UCI HAR Dataset" folder is in the main repo directory along with script file "run_analysis.R"  , , 

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

3.	Open R or R studio and set working directory to cloned repo directory using follwoing withing the console.  
	
	`setwd("<Path on your system>/getting_and_cleaning_data/")`
	
4.  Optional step : If you have not already installed following plyr, sqldf and reshape2 pacages in R then install them using .  

	`install.packages("reshape2")`  
	`install.packages("plyr")`  
	`install.packages("sqldf")`  
	
5.	Run the script using following command in R / R studio. n case of successful run script prompts the location of generated 2 x result files i.e Tidy data for Task1:4 and averages data for Task5.   , , 

	`source("run_analysis.R")`
	*Note : This script and method is tested using Rstudio and R on windows7, and ubuntu 12.04 , On windows with R some times "plyr" and "reshape2" packages give error if you have special some configuration for installing additional R packages. In such cases please refer to following solution.  
	  http://stackoverflow.com/questions/12861014/problems-installing-r-packages
	  The script however needs running "plyr" and "reshape2" packages.
	
	
	