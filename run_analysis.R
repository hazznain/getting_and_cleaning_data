
# Setting the directory path for passing to tidy_data function 
wd <-getwd()
dir_path <- paste(wd,"/UCI HAR Dataset",sep="")

# this function requires directory path and dataset name to return a tidy data frame
# once this function is loaded then directory path parameter can be passed if the data is located in different directory
# dataset parameter can be used to called "test" data set or "train" data. passing any other parameter can give error with given data set. 
# Default dataset is set to "test" data set 
tidy_data <- function(directory= dir_path,dataset = "test") {
                # loading sqldf for later use 
                require(sqldf)
				
		# preparing file path to access target files inside main data director
		# file path for X_test.txt or X_train depending on dataset parameter in function call
                filename_x <- paste(directory,"/",dataset,"/X_",dataset,".txt", sep="")
				
                # file path for y_test.txt or y_train depending on dataset parameter in function call
		filename_y <- paste(directory,"/",dataset,"/y_",dataset,".txt", sep="")
                
		#Reading the list of features to be used as column names for data set
		head_file <- read.table(paste(directory,"/","features.txt",sep=""))
                
		#Reading the list of subject cases depending on data set
		filename_sub <- paste(directory,"/",dataset,"/subject_",dataset,".txt", sep="")
                
		#Reading the data file and setting the respective column names
		data_head <- head_file[,2]   
                data <- read.table (file= filename_x,header=FALSE)
                names(data) <- data_head
                
				# Selecting only the mean() and std() columns as per requirement in task
				# '%mean%(%) and '%std%(%) can capture additional columns like  columns having name pattern as 'meanFreq()'
				# However I choose to not to select like that. In case of more precise instructions the following expression can be modified accordingly.
              	i <- sqldf("Select v1 from head_file where V2 like '%mean()%' or V2 like '%std()%'")
                col_index <- i[,1]
                data <- data [,col_index]
                
		# Reading the activity description and subject list 
		act_list <- read.table(file= filename_y)
                sub_list <- read.table(file= filename_sub)
                colnames(act_list)[1] <- "Activity"
                colnames(sub_list)[1] <- "Subject"
                
		# Inserting the activity description according to activity codes in the activity data set
                act_list <- transform(act_list, ActivityDetail = 
                                            ifelse(act_list$Activity == 1, "WALKING",
                                                   ifelse (act_list$Activity  == 2, "WALKING_UPSTAIRS",
                                                           ifelse( act_list$Activity  ==3, "WALKING_DOWNSTAIRS", 
                                                                   ifelse(act_list$Activity ==4, "SITTING", 
                                                                          ifelse(act_list$Activity ==5, "STANDING","LAYING"
                                                                                 )
                                                                          )
                                                                   )
                                                           )
                                                   )
                                    )
                
                # introducing the activity details and subject information to main data set and setting the labels for it 
				data <- cbind (act_list$ActivityDetail,sub_list$Subject,data)
                colnames(data)[1] <- "ActivityDescription"
                colnames(data)[2] <- "Subject"
                         
                # returning the pre-processed tidy data frame. which will have data depending on the data set parameter passed to this function   
                data
            
}
# acquiring the required libararies
library(plyr)
library(reshape2)


test_data <- tidy_data()                        # collecting the preprocessed tidy test data
train_data <- tidy_data(dataset="train")		# collecting the preprocessed train test data
merged <- merge(train_data,test_data,all=TRUE)  # merging data together 
tidy_data_1 <- merged							# preserving the merged data for later use in calculating averages
tidy_data_1$Subject <-NULL						# removing subject column as it is not required for Task 1:4 output 


# writing the tidy dataset Task 1:4 file with time stamp. So that re-run of script should not create file over-write problem  
path <- getwd() 
appendage <- ".txt" 
t_string <- format(Sys.time(), format = "%Y-%j-%H%M%S") 
tidyFile <- file.path(path, paste0("/","tidy",t_string, appendage,sep="")) 
write.table(tidy_data_1, file = tidyFile,row.names=FALSE) 


# reshaping and aggregation for Task5 
molten = melt(merged, id = c("Subject", "ActivityDescription"))
averages = dcast(molten, formula = Subject + ActivityDescription ~ variable, mean)

# writing the averages dataset Task5 file with time stamp. So that re-run of script should not create file over-write problem 
colnames(averages) <- c("Subject", "ActivityDescription",paste0("avg_of_",names(averages[3:68])))
avgFile <- file.path(path, paste0("/","averages",t_string, appendage,sep="")) 
write.table(averages, file = avgFile,row.names=FALSE)

# Reporting the file generation
print(paste0("File created with tidy data (Task1:4) = ", tidyFile))
print(paste0("File created with averges data (Task5) ", avgFile))


