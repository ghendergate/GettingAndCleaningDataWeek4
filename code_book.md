---
title: "Codebook - run_analysis"
author: "Gabriel"
date: "04/03/2020"
---

### Description of Variables

#### Groups
Subject - indicates the ID of the subject whom was operating the smartphone while measurements were being taken. The values are 1-30.
Activity - indicates the activity which was being carried out while measurements were taken.
  Values for Activity: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

#### Measurements
The general form of the measurement variables are:

timeBodyAccelerometer-XYZ
timeGravityAccelerometer-XYZ
timeBodyAccJerk-XYZ
timeBodyGyroscope-XYZ
timeBodyGyroscopeJerk-XYZ
timeBodyAccelerometerMagnitude
timeGravityAccelerometerMagnitude
timeBodyAccelerometerJerkMagnitude
timeBodyGyroscopeMagnitude
timeBodyGyroscopeJerkMagnitude
frequencyBodyAccelerometer-XYZ
frequencyBodyAccelerometerJerk-XYZ
frequencyBodyGyroscope-XYZ
frequencyBodyAccelerometerMagnitude
frequencyBodyAccelerometerJerkMagnitude
frequencyBodyGyroscopeMagnitude
frequencyBodyGyroscopeJerkMagnitude

Each of the above variables is represented in the output table as summary data. 

For each variable the mean (denoted by suffix ".mean", and standard deviation (denoted by suffix ".standardDeviation) were calculated.

Where  the above variables have suffix -XYZ, the output data separates these into axial data, with the suffixes "-X", "-Y", or "-Z".

Acceleration measurements were separated in "Body" and "Gravity" acceleration signals, as denoted by the prefix to "Accelerometer".

Jerk was derived from the body linear acceleration and angular velocity.

Magnitudes wwere calculated using the Euclidean norm.

The first term of each variable denotes if the measurement is in the frequency or time domain.
