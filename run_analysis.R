library(dplyr)

##### Merges the training and test sets into a single data set
# Load data
# load activity_labels and features
activity_labels <- read.csv("activity_labels.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names = c("index", "activity"))
features <- read.csv("features.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names = c("index", "feature"))



# Load training data
y_train <- read.csv("train/y_train.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
x_train <- read.csv("train/X_train.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names= features$feature)
subject_train <- read.csv("train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
# Add activity and subject columns
merged_train <- mutate(x_train, activity=activity_labels[y_train$index,2], subject=subject_train$index)

# Load test data
y_test <- read.csv("test/y_test.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
x_test <- read.csv("test/X_test.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names= features$feature)
subject_test <- read.csv("test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
# Add activity and subject columns
merged_test <- mutate(x_test, activity=activity_labels[y_test$index,2], subject=subject_test$index)

#Combine training and test data
all_data <- rbind(merged_train, merged_test)


##### Extract the mean and standard deviation variables for each measurement.
all_data_m_sd <- select(all_data, contains("mean") | contains("std") | contains("activity") | contains("subject"))

##### From the data set in the previous step, create a second independent tidy data set with the 
#####     average of each variable for each activity and each subject.

all_data_aggregate <- aggregate(all_data, by=list(all_data$activity, all_data$subject), FUN=mean)
# Add lost names
names(all_data_aggregate)[1:2] <- list("activity", "subject")

# Write the final data table to disc
write.table(all_data_aggregate, file = "analysis_output.csv",row.name = FALSE)