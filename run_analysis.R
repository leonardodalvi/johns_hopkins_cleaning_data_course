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
data.train.x <- read.table('./UCI HAR Dataset/train/X_train.txt')

## Reading training labels
data.train.activity <- read.csv('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')

## Reading training subject
data.train.subject <- read.csv('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

## Creating dataframe with training set, training labels and training subject
data.train <-  data.frame(data.train.subject, data.train.activity, data.train.x)

## Changes names attribute of the data.train dataset
names(data.train) <- c(c('subject', 'activity'), features)

## Reading test set
data.test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')

## Reading test labels
data.test.activity <- read.csv('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')

## Reading test subject
data.test.subject <- read.csv('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

## Creating dataframe with test set, test labels and test subject
data.test <-  data.frame(data.test.subject, data.test.activity, data.test.x)

## Changes names attribute of the data.test dataset
names(data.test) <- c(c('subject', 'activity'), features)

#########################################################################
# Merges the training and testing sets into one dataset called data.all #
#########################################################################

data.all <- rbind(data.train, data.test)

##########################################################################################
# Extracts only the measurements on the mean and standard deviation for each measurement #
##########################################################################################

## Find index of mean and std in features
mean_std.select <- grep('mean|std', features)

## Creating dataframe with only the measurements on the mean and standard deviation for each measurement
data.sub <- data.all[,c(1,2,mean_std.select + 2)]

##########################################################################
# Uses descriptive activity names to name the activities in the data set #
##########################################################################

## Reading activity labels
activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)

## Coerces second column to character
activity.labels <- as.character(activity.labels[,2])

## Replaces activity values in data.sub with labels from activity.labels
data.sub$activity <- activity.labels[data.sub$activity]

#####################################################################
# Appropriately labels the data set with descriptive variable names #
#####################################################################

## Assign names attribute of data.sub in name.new
name.new <- names(data.sub)

## Replaces old names to new descriptive variable names in name.new
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)

## Replaces old names in data.sub with the new ones in name.new
names(data.sub) <- name.new

##############################################################################################################################################
# From the previous dataset, creates a second, independent tidy dataset with the average of each variable for each activity and each subject #
##############################################################################################################################################

## Creates tidy dataset with the average of each variable for each activity and each subject
data.tidy <- aggregate(data.sub[,3:81], by = list(activity = data.sub$activity, subject = data.sub$subject),FUN = mean)

## Writes dataset in text file
write.table(x = data.tidy, file = "data_tidy.txt", row.names = FALSE)
