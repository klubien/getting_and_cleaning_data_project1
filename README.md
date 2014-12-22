## Getting and Cleaning Data Course: Project 1 

# Description of the run_analysis.R script
The function of this script is to create tidy data set

Script does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Running run_analysis.R script
Requirements:
1. Data downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unziped in working directory
2. Package reshape2

Running:
1. Put script in working directory already included folder of the uziped data "UCI HAR Dataset"
2. Run source("run_analysis.R") in the working directory 

# Output
Script creates in the working directory tidy data set named "activity_final.txt" includes average of each variable for each activity and each subject.
