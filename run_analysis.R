
##### Merges the training and test sets into a single data set
# Load data
activity_labels <- read.csv("activity_labels.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names = c("index", "activity"))
features <- read.csv("features.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names = c("index", "feature"))


# Get activity_labels
# Get training data

#   Link data to label
y_train <- read.csv("train/y_train.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
x_train <- read.csv("train/X_train.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names= features$feature)
subject_train <- read.csv("train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
merged_train <- mutate(x_train, activity=activity_labels[y_train$index,2], subject=subject_train$index)

y_test <- read.csv("test/y_test.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
x_test <- read.csv("test/X_test.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names= features$feature)
subject_test <- read.csv("test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
merged_test <- mutate(x_test, activity=activity_labels[y_test$index,2], subject=subject_test$index)

all_data <- rbind(merged_train, merged_test)


##### Extracts only the measurements on the mean and standard deviation for each measurement.
##### Uses descriptive activity names to name the activities in the data set
##### Appropriately labels the data set with descriptive variable names.

all_data_m_sd <- select(all_data, contains("mean") | contains("std") | contains("activity") | contains("subject"))

##### From the data set in step 4, creates a second, independent tidy data set with the 
#####     average of each variable for each activity and each subject.

all_data_aggregate <- aggregate(all_data, by=list(all_data$activity, all_data$subject), FUN=mean)
all_data_aggregate_activity <- aggregate(all_data, by=list(all_data$activity), FUN=mean)
all_data_aggregate_subject <- aggregate(all_data, by=list(all_data$subject), FUN=mean)