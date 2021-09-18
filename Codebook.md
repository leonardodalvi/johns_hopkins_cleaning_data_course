# Codebook

The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project’s definition.

### 1. Downloading Data
- Dataset downloaded and extracted under the folder called UCI HAR Dataset

### 2. Reading and Converting Data
- features <- features.txt : 561 rows, 2 columns
<br>*The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.*

- activity_labels <- activity_labels.txt : 6 rows, 2 columns
<br>*List of activities performed when the corresponding measurements were taken and its codes (labels)*

- data_test_subject <- test/subject_test.txt : 2947 rows, 1 column
<br>*contains test data of 9/30 volunteer test subjects being observed*

- data_test_x <- test/X_test.txt : 2947 rows, 561 columns
<br>*contains recorded features test data*

- data_test_activity <- test/y_test.txt : 2947 rows, 1 columns
<br>*contains test data of activities’code labels*

- data_train_subject <- test/subject_train.txt : 7352 rows, 1 column
<br>*contains train data of 21/30 volunteer subjects being observed*

- data_train_x <- test/X_train.txt : 7352 rows, 561 columns
<br>*contains recorded features train data*

- data_train_activity <- test/y_train.txt : 7352 rows, 1 columns
<br>*contains train data of activities’code labels*

- data_train (7352 rows, 563 columns) is created by merging data_train_subject, data_train_activity and data_train_x, using data.frame() function

- data_test (2947 rows, 563 columns) is created by merging data_test_subject, data_test_activity and data_test_x, using data.frame() function

### 3. Merges the training and testing sets into one dataset called data_all
- data_all (10299 rows, 563 columns) is created by merging data_train and data_test using rbind() function

### 4. Extracts only the measurements on the mean and standard deviation for each measurement
data_sub (10299 rows, 81 columns) is created by subsetting data_all, selecting only columns: subject, activity and the measurements on the mean and standard deviation (std) for each measurement

### 5. Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the data_sub replaced with corresponding activity taken from second column of the activities variable

### 6. Appropriately labels the data set with descriptive variable names
All start with character f in column’s name replaced by FrequencyDomain_
All start with character t in column’s name replaced by TimeDomain_
All Acc in column’s name replaced by Accelerometer
All Gyro in column’s name replaced by Gyroscope
All Mag in column’s name replaced by Magnitude
All -mean- in column’s name replaced by _Mean_
All -std- in column’s name replaced by _StandardDeviation_

### 7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
data_tidy (180 rows, 81 columns) is created by sumarizing data_sub taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export data_tidy into data_tidy.txt file.

## data_tidy dataset

### key columns

Variable name       | Description
--------------------|------------
'activity'          | Label of activity, Factor w/ 6 levels
'subject'           | ID of subject, int (1-30)

### non-key columns

Variable name       | Description
--------------------|------------
'tBodyAcc-mean()-X'   | the average value for this feature, num (range: -1:1)
'tBodyAcc-mean()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyAcc-mean()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyAcc-std()-X'   | the average value for this feature, num (range: -1:1)
'tBodyAcc-std()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyAcc-std()-Z'   | the average value for this feature, num (range: -1:1)
'tGravityAcc-mean()-X'   | the average value for this feature, num (range: -1:1)
'tGravityAcc-mean()-Y'   | the average value for this feature, num (range: -1:1)
'tGravityAcc-mean()-Z'   | the average value for this feature, num (range: -1:1)
'tGravityAcc-std()-X'   | the average value for this feature, num (range: -1:1)
'tGravityAcc-std()-Y'   | the average value for this feature, num (range: -1:1)
'tGravityAcc-std()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerk-mean()-X'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerk-mean()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerk-mean()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerk-std()-X'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerk-std()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerk-std()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyGyro-mean()-X'   | the average value for this feature, num (range: -1:1)
'tBodyGyro-mean()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyGyro-mean()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyGyro-std()-X'   | the average value for this feature, num (range: -1:1)
'tBodyGyro-std()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyGyro-std()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerk-mean()-X'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerk-mean()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerk-mean()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerk-std()-X'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerk-std()-Y'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerk-std()-Z'   | the average value for this feature, num (range: -1:1)
'tBodyAccMag-mean()'   | the average value for this feature, num (range: -1:1)
'tBodyAccMag-std()'   | the average value for this feature, num (range: -1:1)
'tGravityAccMag-mean()'   | the average value for this feature, num (range: -1:1)
'tGravityAccMag-std()'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerkMag-mean()'   | the average value for this feature, num (range: -1:1)
'tBodyAccJerkMag-std()'   | the average value for this feature, num (range: -1:1)
'tBodyGyroMag-mean()'   | the average value for this feature, num (range: -1:1)
'tBodyGyroMag-std()'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerkMag-mean()'   | the average value for this feature, num (range: -1:1)
'tBodyGyroJerkMag-std()'   | the average value for this feature, num (range: -1:1)
'fBodyAcc-mean()-X'   | the average value for this feature, num (range: -1:1)
'fBodyAcc-mean()-Y'   | the average value for this feature, num (range: -1:1)
'fBodyAcc-mean()-Z'   | the average value for this feature, num (range: -1:1)
'fBodyAcc-std()-X'   | the average value for this feature, num (range: -1:1)
'fBodyAcc-std()-Y'   | the average value for this feature, num (range: -1:1)
'fBodyAcc-std()-Z'   | the average value for this feature, num (range: -1:1)
'fBodyAccJerk-mean()-X'   | the average value for this feature, num (range: -1:1)
'fBodyAccJerk-mean()-Y'   | the average value for this feature, num (range: -1:1)
'fBodyAccJerk-mean()-Z'   | the average value for this feature, num (range: -1:1)
'fBodyAccJerk-std()-X'   | the average value for this feature, num (range: -1:1)
'fBodyAccJerk-std()-Y'   | the average value for this feature, num (range: -1:1)
'fBodyAccJerk-std()-Z'   | the average value for this feature, num (range: -1:1)
'fBodyGyro-mean()-X'   | the average value for this feature, num (range: -1:1)
'fBodyGyro-mean()-Y'   | the average value for this feature, num (range: -1:1)
'fBodyGyro-mean()-Z'   | the average value for this feature, num (range: -1:1)
'fBodyGyro-std()-X    | the average value for this feature, num (range: -1:1)
'fBodyGyro-std()-Y'   | the average value for this feature, num (range: -1:1)
'fBodyGyro-std()-Z'   | the average value for this feature, num (range: -1:1)
'fBodyAccMag-mean()'   | the average value for this feature, num (range: -1:1)
'fBodyAccMag-std()'   | the average value for this feature, num (range: -1:1)
'fBodyBodyAccJerkMag-mean()'   | the average value for this feature, num (range: -1:1)
'fBodyBodyAccJerkMag-std()'   | the average value for this feature, num (range: -1:1)
'fBodyBodyGyroMag-mean()'   | the average value for this feature, num (range: -1:1)
'fBodyBodyGyroMag-std()'   | the average value for this feature, num (range: -1:1)
'fBodyBodyGyroJerkMag-mean()'   | the average value for this feature, num (range: -1:1)
'fBodyBodyGyroJerkMag-std()'   | the average value for this feature, num (range: -1:1)
