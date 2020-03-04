---
title: "Codebook - run_analysis"
author: "Gabriel"
date: "04/03/2020"
---

## Project Description
Collect, work with, and clean data relating to tests carried out on the Samsung Galaxy S smartphone, using the data collected from the phone accelerometers. Merge training and test data sets, extract only the mean and standard deviation fields, add appropriate labels, and combine with activity type and subject ID. Then from that data calculate for the mean for each column, grouped by combinations of activity and subject.

###Collection of the raw data
Data was collected from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

###Notes on the original (raw) data 
Full description of the data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

###Guide to create the tidy data file
Download the contents of the repo.
Open RStudio, and ensure that the dplyr package is installed.
Execute the script "run_analysis.R" to create a file named "analysis_output.csv" which contains the processed data, which will be deposited within the same folder as the script.

##Description of the analysis_output.txt file
The first row of data contains the column names, details of which can be found in features.txt and features_info.txt. 
The first column (activity) contains strings as defined within activity_labels.txt, and the second column (subject) indicates the subject ID number. The remaining columns contain numeric data.
The table should have rows of  data and 563 variables (columns).
The data presented is the average value for each variable for each combination of activity and subject. 
