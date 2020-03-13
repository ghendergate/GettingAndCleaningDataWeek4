---
title: "Codebook - run_analysis"
author: "Gabriel"
date: "04/03/2020"
---

The general form of the variables are:

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
For each variable the mean (denoted by suffix ".mean", and standard deviation (denoted by suffex ".standardDeviation) were calculated.
Where  the above variables have suffix -XYZ, the output data separates these into axial data, with the suffixes "-X", "-Y", or "-Z".
Acceleration measurements were separated in "Body" and "Gravity" acceleration signals, as denoted by the prefix to "Accelerometer".
Jerk was derived from the body linear acceleration and angular velocity.
Magnitudes wwere calculated using the Euclidean norm.
The first term of each variable denotes if the measurement is in the frequency or time domain.
