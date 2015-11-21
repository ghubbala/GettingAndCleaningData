#################################################################################################################
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
#    for each activity and each subject.
#################################################################################################################

library(plyr)

###############################################################################
# Create one data set by merging the training and test sets
###############################################################################

#Use read.table to read 'train' files
x_train <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")

#Use read.table to read 'test' files
x_test <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")

# Use rbind to bind x_train and x_test to create 'x_data' data set
x_data <- rbind(x_train, x_test)

# Use rbind to bind y_train and y_test to create 'y_data' data set
y_data <- rbind(y_train, y_test)

# Use rbind to bind subject_train and subject_test to create 'subject_data' data set
subject_data <- rbind(subject_train, subject_test)

#######################################################################################
# Extract only the mean and standard deviation for each measurement
#######################################################################################

#Use read.table to read 'features' files
features <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/features.txt")

#Extract columns with mean() or std() in their names using grep from 'features'
mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the desired columns
x_data <- x_data[, mean_and_std_features]

# correct the column names
names(x_data) <- features[mean_and_std_features, 2]

###############################################################################
# Name the activities in the data set using the descriptive activity names
###############################################################################

#Use read.table to read 'activity_labels' files
activities <- read.table("C:/Bala/Coursera/DataScience/Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

# correct y_data column name
names(y_data) <- "activity"

###############################################################################
# Appropriately label the data set with descriptive variable names
###############################################################################

# correct subject_data column name
names(subject_data) <- "subject"

# bind all the data in a single data set
all_data <- cbind(x_data, y_data, subject_data)

###############################################################################
# Create a tidy data set for each activity and each subject 
# with the average of each variable using ddply
###############################################################################
averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(averages_data, "averages_data_new.txt", row.name=FALSE)
