Load the required library
```
library(dplyr)
```

Load activity_labels.txtand features.txt, ensuring that data is not read as factors, and applying appropriate column names
```
activity_labels <- read.csv("activity_labels.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names = c("index", "activity"))
features <- read.csv("features.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names = c("index", "feature"))
```

Load training data, applying column names where appropriate. 
Note that X_train.txt uses the rows in features as column names.
```
y_train <- read.csv("train/y_train.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
x_train <- read.csv("train/X_train.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names= features$feature)
subject_train <- read.csv("train/subject_train.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
```
Add activity and subject columns to x_train, and translate the activity IDs to the text labels loaded in activity_labels
```
merged_train <- mutate(x_train, activity=activity_labels[y_train$index,2], subject=subject_train$index)
```

Load test data, applying column names where appropriate.
Note that X_test.txt uses the rows in features as column names.
```
y_test <- read.csv("test/y_test.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
x_test <- read.csv("test/X_test.txt", header = FALSE, stringsAsFactors = FALSE, sep = "", col.names= features$feature)
subject_test <- read.csv("test/subject_test.txt", header = FALSE, stringsAsFactors = FALSE, col.names = c("index"))
```
Add activity and subject columns to x_test, and translate the activity IDs to the text labels loaded in activity_labels
```
merged_test <- mutate(x_test, activity=activity_labels[y_test$index,2], subject=subject_test$index)
```

Combine training and test data
```
all_data <- rbind(merged_train, merged_test)
```

Extract the mean and standard deviation variables for each measurement, by filtering the column names according to suffix.
Note that the selection filter specifically preserves activity and subject columns.
```
all_data_m_sd <- select(all_data, contains("mean") | contains("std") | contains("activity") | contains("subject"))
```

Calculate averages for each variable, discretising into groups according to the combinations of activity label and subject ID.
```
all_data_aggregate <- aggregate(all_data, by=list(all_data$activity, all_data$subject), FUN=mean)
```
The previous step loses the column names for activity and subject, so this line of code changes the names to be correct.
```
names(all_data_aggregate)[1:2] <- list("activity", "subject")
```

Write the final data table to disc
```
write.table(all_data_aggregate, file = "analysis_output.csv", row.name = FALSE)
```
