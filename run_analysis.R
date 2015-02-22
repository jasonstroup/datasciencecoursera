run_analysis <- function() {
  ##This script was written by Jason Stroup for "Getting and Cleaning Data" in
  ##Coursera's Data Science Specialization track, Feb 22, 2015.
  ##
  ##This project focuses on the dataset found at the following URL:
  ##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  ##
  ##This script wil perform the following tasks:
  ## 1. Merges the training and the test sets to create one data set.
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  ## 3. Uses descriptive activity names to name the activities in the data set
  ## 4. Appropriately labels the data set with descriptive variable names.
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each
  ## variable for each activity and each subject.
  
  ## This portion will execute item 1 above by merging the datasets from the following files:
  ## features.txt, X_test.txt, Y_test.txt, subject_test.txt, X_train.txt, Y_train.txt,
  ## subject_train.txt.
  print("loading test data for analysis...")
  features <- read.table("features.txt") ## reads the variable names (features) into memory
  x_test <- read.table("test/X_test.txt") ## reads raw data (X_test)
  colnames(x_test) <- features[,2] ## assigns column names from the features tables
  y_test <- read.table("test/Y_test.txt", col.names = "activity") ## reads activity numbers (Y_test) into memory)
  x_test <- cbind(y_test,x_test) ## combines the raw data (X_test) and activity numbers (Y_test) tables
  ## This portion will read the subject_test.txt file and add it as a column to the x_test table  
  subject_test <- read.table("test/subject_test.txt", col.names = "subject") ## reads data from table & assigns column name
  x_test <- cbind(subject_test,x_test) ## adds the subject ids to the dataset
  rm(y_test,subject_test) ##removes extraneous data from memory 
  ## This section performs the same task as above, but for the training data instead of the test data
  print("loading training data for analysis...")
  x_train <- read.table("train/X_train.txt") ## reads raw data (X_train)
  colnames(x_train) <- features[,2] ## assigns column names from the features table
  y_train <- read.table("train/Y_train.txt", col.names = "activity") ## reads activity numbers (Y_train) into memory
  x_train <- cbind(y_train,x_train) ## combines the raw data (X_train) and activity numbers (Y_train) tables
  ## This portion will read the subject_train.txt file and add it as a column to X_train table  
  subject_train <- read.table("train/subject_train.txt", col.names = "subject") ## reads data from table & assigns column name
  x_train <- cbind(subject_train, x_train) ## adds the subject ids to the dataset 
  rm(y_train,subject_train) ## removes extraneous data from memory
  ## This section will merge the test and train datasets into a single table
  print("merging data...")
  data <- rbind(x_test,x_train) ## merges the two datasets into a table called "data"
  rm(features, x_test, x_train) ## removes extraneous data from memory
    
  ## This section relates to part 2 of the project.  It will identify the columns with either "mean()"
  ## or "std()" in the column name and extract those columns (along with the subject and activity)
  ## into a separate table called new_dat
  print("extracting mean and standard deviation variables...")
  meanCols <- grep("mean()",names(data), value= TRUE) ## identifies all of the columns with "mean()" in the name
  stdCols <- grep("std()", names(data), value = TRUE) ## identifies all of the columns with "std()" in the name
  colList <- c("subject", "activity", meanCols, stdCols) ## creates a vector of all columns we want to extract
  new_dat <- data[colList] ## creates a new table with only the previously identified data columns
  rm(data) ## removes extraneous data from memory
  
  ## This section is for part 3 of the project.  It will replace the activity values in the new_dat table 
  ## with the description provided in the activity_labels.txt file.
  print("assigning acitivity labels...")
  activity_labels <- read.table("activity_labels.txt") ## reads activity labels from file
  ## the for loop below looks at each activity value in new_dat and replaces it with the descriptive label
  for (i in 1:nrow(activity_labels)) {
    new_dat$activity[new_dat$activity==activity_labels[i,1]] <- as.character(activity_labels[i,2])
  }
  
  ## This section accomplishes part 4 of the project and creates the dataset to be exported in part 5.
  print("grouping data by subject and activity...")
  library(dplyr) ## loads the dplyr package so we can utilize the group_by and summarise_each functions
  res <- new_dat %>% group_by(subject,activity) %>% summarise_each(funs(mean))  ## creates a new table 
  ## called res which groups the data by subject and activity, then calculates the average values for 
  ## each variable in the group.
  colnames(res)[3:ncol(res)] <- paste("Avg", colnames(new_dat)[3:ncol(res)],sep="_") ## renames the
  ## variable columns to indicate that the data in each column are the calculated averages for the 
  ## sample set.
  rm(new_dat) ## removes extraneous data memory
  
  ## This section accomplishes the last portion of the project by saving the resulting data to a file 
  ## in the working directory called final.results.txt
  print("writing new dataset...")
  write.table(res,"final.result.txt", row.name=FALSE) ## writes results to text file without the row names
  print("dataset exported to final.result.txt")
  rm(res) ## removes extraneous data from memory
}