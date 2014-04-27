wd <-getwd()
dir_path <- paste(wd,"/UCI HAR Dataset",sep="")

tidy_data <- function(directory= dir_path,dataset = "test", avgs = FALSE) {
                
                require(sqldf)
                filename_x <- paste(directory,"/",dataset,"/X_",dataset,".txt", sep="")
                filename_y <- paste(directory,"/",dataset,"/y_",dataset,".txt", sep="")
                head_file <- read.table(paste(directory,"/","features.txt",sep=""))
                filename_sub <- paste(directory,"/",dataset,"/subject_",dataset,".txt", sep="")
                data_head <- head_file[,2]   
                data <- read.table (file= filename_x,header=FALSE)
                names(data) <- data_head
                complete_data <- data
                i <- sqldf("Select v1 from head_file where V2 like '%mean()%' or V2 like '%std()%'")
                col_index <- i[,1]
                data <- data [,col_index]
                act_list <- read.table(file= filename_y)
                sub_list <- read.table(file= filename_sub)
                colnames(act_list)[1] <- "Activity"
                colnames(sub_list)[1] <- "Subject"
                
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
                
                data <- cbind (act_list$ActivityDetail,sub_list$Subject,data)
                colnames(data)[1] <- "ActivityDescription"
                colnames(data)[2] <- "Subject"
                         
                  
                data
            
}
test_data <- tidy_data()
train_data <- tidy_data(dataset="train")
merged <- merge(train_data,test_data,all=TRUE)
tidy_data_1 <- merged
tidy_data_1$Subject <-NULL


path <- getwd() 
appendage <- ".txt" 
t_string <- format(Sys.time(), format = "%Y-%j-%H%M%S") 
tidyFile <- file.path(path, paste0("/","tidy",t_string, appendage,sep="")) 
write.table(tidy_data_1, file = tidyFile,row.names=FALSE) 



molten = melt(merged, id = c("Subject", "ActivityDescription"))
averages = dcast(molten, formula = Subject + ActivityDescription ~ variable, mean)

colnames(averages) <- c("Subject", "ActivityDescription",paste0("avg_of_",names(averages[3:68])))
avgFile <- file.path(path, paste0("/","averages",t_string, appendage,sep="")) 
write.table(averages, file = avgFile,row.names=FALSE)

print(paste0("File created with tidy data (Task1:4) = ", tidyFile))
print(paste0("File created with averges data (Task5) ", avgFile))


