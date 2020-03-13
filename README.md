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

Combine training and test data, by appending the rows from merged_test to merged_train.
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
all_data_aggregate <- aggregate(all_data_m_sd, by=list(all_data$activity, all_data$subject), FUN=mean)
```
The previous step loses the column names for activity and subject, and leaves leftover columns at the end of the table, so this  changes the names to be correct and removes the leftover columns.
```
names(all_data_aggregate)[1:2] <- list("activity", "subject")
all_data_aggregate <- all_data_aggregate[1:88]
```
Construct a list of human-readable terms, each of which has a name that is the regex search term
```
nameRegister <- c("Time", 
                  "Frequency", 
                  "Accelerometer",
                  "Gyroscope",
                  "Magnitude",
                  "standardDeviation",
                  "",
                  "-")
names(nameRegister) <- c("^t|\\.t", # only match first character element or character preceded by "."
                         "^f|Freq\\.", # only match first character element or abbreviation followed by "."
                         "Acc",
                         "Gyro",
                         "Mag",
                         "std",
                         "\\.{1,}$", # match any number of consecutive trailing ".",
                         "\\.{1,}(?=[A-Z])" # match any number of consecutive "." followed by capital letter with "-" (i.e. lookahead, requires perl=TRUE)
                         )
```

Loop through the regex search terms and match/replace values in each column title. 
```
i <- 1
for (n in names(all_data_aggregate)){
  tempColumnName <- n # do name operations on a temporary variable
  for (title in names(nameRegister)){ # replace every matching abbreviation
    tempColumnName <- gsub(title, tempColumnName, replacement=nameRegister[title], perl=TRUE)
  }
  names(all_data_aggregate)[i] <- tempColumnName
  i <- i + 1
}
```

Write the final data table to disc
```
write.table(all_data_aggregate, file = "analysis_output.txt", row.name = FALSE)
```
