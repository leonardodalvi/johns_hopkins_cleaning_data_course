####################
# Downloading Data #
####################

## Import library data.table
library(data.table)

## Download Dataset
file_url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

if (!file.exists('./UCI HAR Dataset.zip')){
    download.file(file_url,'./UCI HAR Dataset.zip', mode = 'wb')
    unzip("UCI HAR Dataset.zip", exdir = getwd())
}

###############################
# Reading and Converting Data #
###############################

## Reading list of all features
features <- read.csv('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')

## Coerces second column to character
features <- as.character(features[,2])

## Reading training set
data_train_x <- read.table('./UCI HAR Dataset/train/X_train.txt')

## Reading training labels
data_train_activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')

## Reading training subject
data_train_subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

## Creating dataframe with training set, training labels and training subject
data_train <-  data.frame(data_train_subject, data_train_activity, data_train_x)

## Changes names attribute of the data.train dataset
names(data_train) <- c(c('subject', 'activity'), features)

## Reading test set
data_test_x <- read.table('./UCI HAR Dataset/test/X_test.txt')

## Reading test labels
data_test_activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')

## Reading test subject
data_test_subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

## Creating dataframe with test set, test labels and test subject
data_test <- data.frame(data_test_subject, data_test_activity, data_test_x)

## Changes names attribute of the data.test dataset
names(data_test) <- c(c('subject', 'activity'), features)

#########################################################################
# Merges the training and testing sets into one dataset called data.all #
#########################################################################

data_all <- rbind(data_train, data_test)

##########################################################################################
# Extracts only the measurements on the mean and standard deviation for each measurement #
##########################################################################################

## Find index of mean and std in features
mean_std_select <- grep('mean|std', features)

## Creating dataframe with only the measurements on the mean and standard deviation for each measurement
data_sub <- data_all[,c(1,2,mean_std_select + 2)]

##########################################################################
# Uses descriptive activity names to name the activities in the data set #
##########################################################################

## Reading activity labels
activity_labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)

## Coerces second column to character
activity_labels <- as.character(activity_labels[,2])

## Replaces activity values in data.sub with labels from activity.labels
data_sub$activity <- activity_labels[data_sub$activity]

#####################################################################
# Appropriately labels the data set with descriptive variable names #
#####################################################################

## Assign names attribute of data.sub in name.new
name_new <- names(data_sub)

## Replaces old names to new descriptive variable names in name.new
name_new <- gsub("[(][)]", "", name_new)
name_new <- gsub("^t", "TimeDomain_", name_new)
name_new <- gsub("^f", "FrequencyDomain_", name_new)
name_new <- gsub("Acc", "Accelerometer", name_new)
name_new <- gsub("Gyro", "Gyroscope", name_new)
name_new <- gsub("Mag", "Magnitude", name_new)
name_new <- gsub("-mean-", "_Mean_", name_new)
name_new <- gsub("-std-", "_StandardDeviation_", name_new)
name_new <- gsub("-", "_", name_new)

## Replaces old names in data.sub with the new ones in name.new
names(data_sub) <- name_new

##############################################################################################################################################
# From the previous dataset, creates a second, independent tidy dataset with the average of each variable for each activity and each subject #
##############################################################################################################################################

## Creates tidy dataset with the average of each variable for each activity and each subject
data_tidy <- aggregate(data_sub[,3:81], by = list(activity = data_sub$activity, subject = data_sub$subject),FUN = mean)

## Writes dataset in text file
write.table(x = data_tidy, file = "data_tidy.txt", row.names = FALSE)
