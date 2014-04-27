#The Code Book
Code book contains the description of the data set that was manipulated to get the the tidy data sets as per requirements of the task described in Readme.md file. It also contains the steps performed to manipulate the data and the description of the variable in both tidy data output files.

## Data set higlights
This section highlights the elements that were used to create the tidy data set. More detailed description of data set is available in README.txt file inside data and on following link.   
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

1. Files of Interest    
*UCI HAR Dataset/README.txt  : contains the descriptive information of data set.      
*UCI HAR Dataset/features.txt: List of feature with feature number. Total of 561 different features. The feature names were used as column names for our tidy data sets.     
*UCI HAR Dataset/activity_labels.txt': Links the class labels with their activity name. 6 Activities total. This file was use in script to assign activity description in front of activity codes.       
*UCI HAR Dataset/train/X_train.txt: Training set with Measure measurements of 561 features. Total trainin observations were 7352. Used as main data set for training data before merging.    
*UCI HAR Dataset/train/y_train.txt: Training activity labels corresponding to observations in the train X_train.txt.      
*UCI HAR Dataset/test/X_test.txt: Test set with measurements of 561 features. Total test observations were 2947. Used as main data set for test data before merging.     
*UCI HAR Dataset/test/y_test.txt:  activity labels corresponding to observations in the train X_test.txt.    
