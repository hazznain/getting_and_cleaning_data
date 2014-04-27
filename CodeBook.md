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

### Finalizing Task5, The Average Aggregation   
to calculate and project average measurements for each subject doing each activity. melt() function was used to get the measurement as variable for subject and activities. Then dcast() to aggregate and reshape data in a form that each subject activities list in from of it with respective averages of all measurements. Total of 180 rows explain 30 subject X 6 activities each. Just before sending it to write output file the labels of the casted data frame were modified to make it tidy.

### Writing the output files
To avoid rewrite issues in case of script re-run dumping output file in same directory. Output files are with time stamp appended as "%Y-%j-%H%M%S" i.e. year-NumberOfTheDayInYear-HourMinuteSecond. 


  
