---
title: "CodeBook.md"
author: "Maria Makarenkova"
date: "April 24, 2016"
---
Introduction
===========
* Experimental design and background: 
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

* Raw data: 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

For more details please refer to http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

(c) Introduction and raw data details are taken from the web site above. 

* Processed data (TidyDataLong.txt): 
There are following transformations have been made to the raw data:

1) Merges the training and the test sets to create one data set
2) Extracts only the measurements on the mean - mean() and standard deviation - std() for each measurement
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (volunteer)

The structure of the data set (11880 observations of 4 variables):

| volunteer | activitydesc     | variable                | value              |
|-----------|------------------|-------------------------|--------------------|
| 1         | LAYING           | tbodyaccmeanx           | 0.22159824394      |
| 2         | LAYING           | tbodyaccmeanx           | 0.281373403958333  |
| 3         | LAYING           | tbodyaccmeanx           | 0.275516852741935  |
| 4         | LAYING           | tbodyaccmeanx           | 0.263559214981481  |
|...........|..................|.........................|....................|
|           |                  |                         |                    |
| 26        | WALKING_UPSTAIRS | fbodybodygyrojerkmagstd | -0.669846294545455 |
| 27        | WALKING_UPSTAIRS | fbodybodygyrojerkmagstd | -0.751714312941177 |
| 28        | WALKING_UPSTAIRS | fbodybodygyrojerkmagstd | -0.70485275745098  |
| 29        | WALKING_UPSTAIRS | fbodybodygyrojerkmagstd | -0.756464186122449 |
| 30        | WALKING_UPSTAIRS | fbodybodygyrojerkmagstd | -0.791349425076923 |

It is a long tidy data text file that meets the principles of tidy data described in Hadley Wickham's paper where

* "volunteer"
 Each value represents one of 30 volunteers within an age bracket of 19-48 years:
 "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11" "12" "13" "14" "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28" "29" "30"
 
* "activitydesc"
  Each value represents one of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) that each of the volunteers performed wearing a smartphone (Samsung Galaxy S II) on the waist.

* "variable"
 Each value corresponds to the measurement name (feature) from the raw data. However, only the measurements on the mean - mean() and standard deviation - std() for each of the orginal measurement made to the processed data (66 measurements out of 561). According to the course naming conventions all column names are lower case and "-", "(" and ")" symbols are removed from the original measurements' names.
 
    [1] "tbodyaccmeanx"            "tbodyaccmeany"            "tbodyaccmeanz"            "tbodyaccstdx"             "tbodyaccstdy"             "tbodyaccstdz"             "tgravityaccmeanx"         "tgravityaccmeany"        
    [9] "tgravityaccmeanz"         "tgravityaccstdx"          "tgravityaccstdy"          "tgravityaccstdz"          "tbodyaccjerkmeanx"        "tbodyaccjerkmeany"        "tbodyaccjerkmeanz"        "tbodyaccjerkstdx"        
    [17] "tbodyaccjerkstdy"         "tbodyaccjerkstdz"         "tbodygyromeanx"           "tbodygyromeany"           "tbodygyromeanz"           "tbodygyrostdx"            "tbodygyrostdy"            "tbodygyrostdz"           
    [25] "tbodygyrojerkmeanx"       "tbodygyrojerkmeany"       "tbodygyrojerkmeanz"       "tbodygyrojerkstdx"        "tbodygyrojerkstdy"        "tbodygyrojerkstdz"        "tbodyaccmagmean"          "tbodyaccmagstd"          
    [33] "tgravityaccmagmean"       "tgravityaccmagstd"        "tbodyaccjerkmagmean"      "tbodyaccjerkmagstd"       "tbodygyromagmean"         "tbodygyromagstd"          "tbodygyrojerkmagmean"     "tbodygyrojerkmagstd"     
    [41] "fbodyaccmeanx"            "fbodyaccmeany"            "fbodyaccmeanz"            "fbodyaccstdx"             "fbodyaccstdy"             "fbodyaccstdz"             "fbodyaccjerkmeanx"        "fbodyaccjerkmeany"       
    [49] "fbodyaccjerkmeanz"        "fbodyaccjerkstdx"         "fbodyaccjerkstdy"         "fbodyaccjerkstdz"         "fbodygyromeanx"           "fbodygyromeany"           "fbodygyromeanz"           "fbodygyrostdx"           
    [57] "fbodygyrostdy"            "fbodygyrostdz"            "fbodyaccmagmean"          "fbodyaccmagstd"           "fbodybodyaccjerkmagmean"  "fbodybodyaccjerkmagstd"   "fbodybodygyromagmean"     "fbodybodygyromagstd"     
    [65] "fbodybodygyrojerkmagmean" "fbodybodygyrojerkmagstd" 

* "value"
 Each value is the average of each variable for each activity and each subject (volunteer). Values are normalized and bounded within [-1,1].
 
     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
-0.99770 -0.96210 -0.46990 -0.48440 -0.07836  0.97450 
