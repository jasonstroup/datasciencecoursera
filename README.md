---
title: "README"
output: html_document
---

This script was written by Jason Stroup for "Getting and Cleaning Data" in
Coursera's Data Science Specialization track, Feb 22, 2015.

This project focuses on the dataset found at the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This script wil perform the following tasks:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The first portion of the script will execute part 1 above by merging the datasets from the following files:
*features.txt*, *X_test.txt*, *Y_test.txt*, *subject_test.txt*, *X_train.txt*, *Y_train.txt*, *subject_train.txt*.  This section primarily uses the read.table, cbind and rbind functions to combine the data collected from these files into a single dataset called *data*.

The second portion of the script will execute part 2 above.  It will use the grep function to identify the columns with either "mean()" or "std()" in the column name and extract those columns (along with the subject and activity) into a separate table called *new_dat*.

The third portion of the script will execute part 3 of the project as shown above.  It will use the read.table function to load the activity names from the file *activity_labels.txt*.  It also uses a for loop to  replace the activity values in the *new_dat* table with the more descriptive activity names.

The fourth section accomplishes part 4 of the project and creates the dataset which will be exported in part 5.  It loads the dplyr library so we can usee the *group_by* and *summarise_each* functions.  These functions are used to group the data by subject and activity, then computes the mean of each variable. This new data is stored in a table called *res*.  Finally, the paste function is used to rename the variable columns to reflect this transformation.

The final portion of the script executes part 5 of the project by saving the resulting data to a file using the write.table function. The results of our analysis are then exported to the working directory in a file called *final.results.txt*.
  