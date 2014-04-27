#The Code Book
Code book contains the description of the data set that was manipulated to get the the tidy data sets as per requirements of the task described in Readme.md file. It also contains the steps performed to manipulate the data and the description of the variable in both tidy data output files.

### Data set higlights
This section highlights the elements that were used to create the tidy data set. More detailed description of data set is available in README.txt file inside data and on following link.   
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

#### Files of Interest    
1.	`UCI HAR Dataset/README.txt`  : contains the descriptive information of data set.      
2.	`UCI HAR Dataset/features.txt`: List of feature with feature number. Total of 561 different features. The feature names were used as column names for our tidy data sets.     
3.	`UCI HAR Dataset/activity_labels.txt`: Links the class labels with their activity name. 6 Activities total. This file was use in script to assign activity description in front of activity codes.       
4.	`UCI HAR Dataset/train/X_train.txt`: Training set with Measure measurements of 561 features. Total trainin observations were 7352. Used as main data set for training data before merging.    
5.	`UCI HAR Dataset/train/y_train.txt`: Training activity labels corresponding to observations in the train X_train.txt. 
6.	`UCI HAR Dataset/test/subject_train.txt` : subject list corresponding to train data.       
7.	`UCI HAR Dataset/test/X_test.txt`: Test set with measurements of 561 features. Total test observations were 2947. Used as main data set for test data before merging.     
8.	`UCI HAR Dataset/test/y_test.txt`:  activity labels corresponding to observations in the train X_test.txt.   
9.	`UCI HAR Dataset/test/subject_test.txt`: subject list corresponding to test data.

### Data Loading & Pre-Processing.

run_analysis.R script uses tidy_data() function to load and pre-process data. tidy_data() function requires two parameters as input i.e directory path of the dataset and dataset that you want to pre-process. There are two possible correct values for dataset parameter i.e. "test" that can load and process test data while second option is "train" that can load train data. By default tidy_data loads and processes test dataset. Data loading is done using read.table() with appropriate path prepared through paste() function.   

Processing involves taking feature label from features.txt and labelling respective measures as column names in X_train.txt or X_test.txt depending on dataset parameter in tidy_data() function call. This sets our base data frame ("data" in script) that will keep tranforming during pre-processing as per task requirements. Required columns were picked from base data frame as required.  Then activity codes are added from y_train.txt/ y_test.txt and subject id from subject_train.txt/subject_test.txt to corresponding measurements in  the base data frame. Activity descriptions are picked from acitivity_labels.txt and inserted into base data frame in front of corresponding activity code. Labels of the required are adjusted to be meaningful in the transformed base data frame that is now ready as output of tidy_data() function.

### Finalizing Task1:4, The Tidy Dataset
tidy_data() is called twice, once to get test data and second to get training data. Then both data frames were merged together. Before sending it to write as output file subject details were removed as it was not required as per task requirement. The original merged data frame was also preserved to be used for task5.
###### Variables in Tidy Data Set
[1] "ActivityDescription"         "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
 [5] "tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"            "tGravityAcc-mean()-X"       
 [9] "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"         "tGravityAcc-std()-Y"        
[13] "tGravityAcc-std()-Z"         "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"      
[17] "tBodyAccJerk-std()-X"        "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"        "tBodyGyro-mean()-X"         
[21] "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"           "tBodyGyro-std()-Y"          
[25] "tBodyGyro-std()-Z"           "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"     
[29] "tBodyGyroJerk-std()-X"       "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"       "tBodyAccMag-mean()"         
[33] "tBodyAccMag-std()"           "tGravityAccMag-mean()"       "tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"     
[37] "tBodyAccJerkMag-std()"       "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"    
[41] "tBodyGyroJerkMag-std()"      "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"           "fBodyAcc-mean()-Z"          
[45] "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"      
[49] "fBodyAccJerk-mean()-Y"       "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"       
[53] "fBodyAccJerk-std()-Z"        "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"          "fBodyGyro-mean()-Z"         
[57] "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"           "fBodyAccMag-mean()"         
[61] "fBodyAccMag-std()"           "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"    
[65] "fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 

### Finalizing Task5, The Average Aggregation   
to calculate and project average measurements for each subject doing each activity. melt() function was used to get the measurement as variable for subject and activities. Then dcast() to aggregate and reshape data in a form that each subject activities list in from of it with respective averages of all measurements. Total of 180 rows explain 30 subject X 6 activities each. Just before sending it to write output file the labels of the casted data frame were modified to make it tidy.
###### Variables in Averages data set
``
[1] "Subject"                            "ActivityDescription"                "avg_of_tBodyAcc-mean()-X"          
 [4] "avg_of_tBodyAcc-mean()-Y"           "avg_of_tBodyAcc-mean()-Z"           "avg_of_tBodyAcc-std()-X"           
 [7] "avg_of_tBodyAcc-std()-Y"            "avg_of_tBodyAcc-std()-Z"            "avg_of_tGravityAcc-mean()-X"       
[10] "avg_of_tGravityAcc-mean()-Y"        "avg_of_tGravityAcc-mean()-Z"        "avg_of_tGravityAcc-std()-X"        
[13] "avg_of_tGravityAcc-std()-Y"         "avg_of_tGravityAcc-std()-Z"         "avg_of_tBodyAccJerk-mean()-X"      
[16] "avg_of_tBodyAccJerk-mean()-Y"       "avg_of_tBodyAccJerk-mean()-Z"       "avg_of_tBodyAccJerk-std()-X"       
[19] "avg_of_tBodyAccJerk-std()-Y"        "avg_of_tBodyAccJerk-std()-Z"        "avg_of_tBodyGyro-mean()-X"         
[22] "avg_of_tBodyGyro-mean()-Y"          "avg_of_tBodyGyro-mean()-Z"          "avg_of_tBodyGyro-std()-X"          
[25] "avg_of_tBodyGyro-std()-Y"           "avg_of_tBodyGyro-std()-Z"           "avg_of_tBodyGyroJerk-mean()-X"     
[28] "avg_of_tBodyGyroJerk-mean()-Y"      "avg_of_tBodyGyroJerk-mean()-Z"      "avg_of_tBodyGyroJerk-std()-X"      
[31] "avg_of_tBodyGyroJerk-std()-Y"       "avg_of_tBodyGyroJerk-std()-Z"       "avg_of_tBodyAccMag-mean()"         
[34] "avg_of_tBodyAccMag-std()"           "avg_of_tGravityAccMag-mean()"       "avg_of_tGravityAccMag-std()"       
[37] "avg_of_tBodyAccJerkMag-mean()"      "avg_of_tBodyAccJerkMag-std()"       "avg_of_tBodyGyroMag-mean()"        
[40] "avg_of_tBodyGyroMag-std()"          "avg_of_tBodyGyroJerkMag-mean()"     "avg_of_tBodyGyroJerkMag-std()"     
[43] "avg_of_fBodyAcc-mean()-X"           "avg_of_fBodyAcc-mean()-Y"           "avg_of_fBodyAcc-mean()-Z"          
[46] "avg_of_fBodyAcc-std()-X"            "avg_of_fBodyAcc-std()-Y"            "avg_of_fBodyAcc-std()-Z"           
[49] "avg_of_fBodyAccJerk-mean()-X"       "avg_of_fBodyAccJerk-mean()-Y"       "avg_of_fBodyAccJerk-mean()-Z"      
[52] "avg_of_fBodyAccJerk-std()-X"        "avg_of_fBodyAccJerk-std()-Y"        "avg_of_fBodyAccJerk-std()-Z"       
[55] "avg_of_fBodyGyro-mean()-X"          "avg_of_fBodyGyro-mean()-Y"          "avg_of_fBodyGyro-mean()-Z"         
[58] "avg_of_fBodyGyro-std()-X"           "avg_of_fBodyGyro-std()-Y"           "avg_of_fBodyGyro-std()-Z"          
[61] "avg_of_fBodyAccMag-mean()"          "avg_of_fBodyAccMag-std()"           "avg_of_fBodyBodyAccJerkMag-mean()" 
[64] "avg_of_fBodyBodyAccJerkMag-std()"   "avg_of_fBodyBodyGyroMag-mean()"     "avg_of_fBodyBodyGyroMag-std()"     
[67] "avg_of_fBodyBodyGyroJerkMag-mean()" "avg_of_fBodyBodyGyroJerkMag-std()" 
``


### Writing the output files
To avoid rewrite issues in case of script re-run dumping output file in same directory. Output files are with time stamp appended as "%Y-%j-%H%M%S" i.e. year-NumberOfTheDayInYear-HourMinuteSecond.
 


  
