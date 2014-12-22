#create object "test_files" with the list path to the files in directory "./UCI HAR Dataset/test"
test_files <- list.files("./UCI HAR Dataset/test", full.names = TRUE)

#create object "train_files" with the list path to the files in directory "./UCI HAR Dataset/train"
train_files <- list.files("./UCI HAR Dataset/train", full.names = TRUE)

#read into r file "x_test.txt"
x_test <- read.table(test_files[3])
source
#read into r file "y_test.txt"
y_test <- read.table(test_files[4])

#read into r file "subject_test.txt"
subject_test <- read.table(test_files[2])

#add first column from subject_test to the x_test data set with the name subject_id
x_test$subject_id <- subject_test[, 1]

#add first column from y_test to the x_test data set with the name activity_label
x_test$activity_labels <- y_test[, 1]

#read into r file "x_train.txt"
x_train <- read.table(train_files[3])

#read into r file "y_train.txt"
y_train <- read.table(train_files[4])

#read into r file "subject_train.txt"
subject_train <- read.table(train_files[2])

#add first column from subject_train to the x_train data set with the name subject_id
x_train$subject_id <- subject_train[, 1] 

#add first column from y_train to the x_train data set with the name activity_labels
x_train$activity_labels <- y_train[, 1]

#join x_test and x_train datasests using rbind function
activity_data <- rbind(x_test, x_train)

#remove y_test, y_train, x_train, x_test, subject_train, subject_test object from r
rm(y_test, y_train, x_train, x_test, subject_train, subject_test)

#remove file_url, test_files, train_files objects from r
rm(test_files, train_files)

#read into r file "features.txt"
features_label <- read.table("./UCI HAR Dataset/features.txt")

#assign variable names to the activity_data dataset using column 2 from features_label dataset
names(activity_data) <- features_label[, 2]

#change name of the column 562 of the activity_data dataset to "subject_id"
names(activity_data)[562] <- "subject_id"

#change name of the column 563 of the activity_data dataset to "activity_labels"
names(activity_data)[563] <- "activity_labels"

#remove object featureslabel from r 
rm(features_label)

#select variables containing "mean" and "std" from the activity data and put them int new object activity_data_subset
activity_data_subset <- activity_data[c(grep("mean", names(activity_data)), grep("std", names(activity_data)))]

#copy variable(column) subject_id from activity_data to activity_data_subset dataset
activity_data_subset$subject_id <- activity_data$subject_id

#copy variable(column) activity_labels from activity_data to activity_data_subset dataset
activity_data_subset$activity_labels <- activity_data$activity_labels

#change varibale activity_lables from integer to character : activity_data_subset data set
activity_data_subset$activity_labels <- as.character(activity_data_subset$activity_labels)

#rename activity_lables 1 to walking in activity_data_subset data frame 
activity_data_subset$activity_labels[activity_data_subset$activity_labels == "1"] <- "walking"

#rename activity_lables 2 to walkingupstairs in activity_data_subset data frame
activity_data_subset$activity_labels[activity_data_subset$activity_labels == "2"] <- "walking_upstairs"

#rename activity_lables 3 to walking_downstairs in activity_data_subset data frame
activity_data_subset$activity_labels[activity_data_subset$activity_labels == "3"] <- "walking_downstairs"

#rename activity_lables 4 to sitting in activity_data_subset data frame
activity_data_subset$activity_labels[activity_data_subset$activity_labels == "4"] <- "sitting"

#rename activity_lables 5 to standing in activity_data_subset data frame
activity_data_subset$activity_labels[activity_data_subset$activity_labels == "5"] <- "standing"

#rename activity_lables 6 to laying in activity_data_subset data frame
activity_data_subset$activity_labels[activity_data_subset$activity_labels == "6"] <- "laying"

#load package reshape2
library(reshape2)

#melt activity_data_subset data set and put it into new object activity_data_melt using vriables subject_id
#and activity lables as id variable
activity_data_melt <- melt(activity_data_subset, id = c("subject_id", "activity_labels"))

#create object activity_final which includes average(mean) of each variable for each activity and each subject
activity_final <- dcast(activity_data_melt, subject_id + activity_labels ~ variable, mean)

#delete activity_data, activity_data_subset and activity_data_melt object from r
rm(activity_data, activity_data_subset, activity_data_melt)

#write as a file activity_final.txt data set activity_final
write.table(activity_final, file = "activity_final.txt", row.name = FALSE)
