Introduction
===========

This R script is called run_analysis.R. It collects, cleans a data set and finally prepares tidy data that can be used for later analysis. Data set represents the data collected from the accelerometers from the Samsung Galaxy S smartphone. More detailed description is available in Code Book (CodeBook.md) for this assighment. 

run_analysis.R that does the following:

* Dowloads and uzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* Load train and test data sets, column names and acitvity labels
* Merges the training and the test sets to create one data set
* Extracts only the measurements on the mean - mean() and standard deviation - std() for each measurement (66 measurements out of 561)
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject


Step-by-step instructions on each bullet point: 
===========

* Dowloads and uzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip:

    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile = "Dataset.zip", method = "curl") ##to run on Windows - remove method = "curl"
    unzip("Dataset.zip")
    unlink("Dataset.zip") ## Delete archive

* Load train and test data sets, column names and acitvity labels

    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE) ##7352 observations of 561 variables
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE) ##7352 observations of 1 variables
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE) ##7352 observations of 1 variables
    
    x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE) ##2947 observations of 561 variables
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE) ##2947 observations of 1 variables
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE) ##2947 observations of 1 variables
    
    ColNames <- read.table("./UCI HAR Dataset/features.txt", header = FALSE) ##561 observations of 2 variables
    Activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE) ##6 observations of 2 variables
    colnames(Activity_Labels) <- c("label", "activitydesc")
    
* Extracts only the measurements on the mean - mean() and standard deviation - std() for each measurement
  
    x <- rbind(x_train, x_test) ##10299 observations of 561 variables
    y <- rbind(y_train, y_test) ##10299 observations of 1 variables
    colnames(y) <- c("label")
    subject <- rbind(subject_train, subject_test) ##10299 observations of 1 variables
    subject$V1 <- as.factor(subject$V1) ## according to the course guidelines made variable with character values into factor variable
    colnames(subject) <- c("volunteer")
    
    x_train <-NULL; x_test <- NULL; y_train <- NULL; y_test <- NULL; subject_train <- NULL; subject_test <- NULL ##Release memory space from train and test data.frames
    
    x <- x[grepl("mean()", ColNames$V2, fixed=TRUE) | grepl("std()", ColNames$V2, fixed=TRUE)] ##Extracts only the measurements on the mean - mean() and standard deviation - std() for each measurement
    x <- cbind(subject, y, x) ##combine subjects, activity label codes and measurements in one data set

* Uses descriptive activity names to name the activities in the data set

    x = merge(x,Activity_Labels,by="label",all.x=TRUE) ##Add descriptive names of activity codes to the data set
    x$activitydesc <- as.factor(x$activitydesc) ## according to the course guidelines made variable with character values into factor variable
    
* Appropriately labels the data set with descriptive variable names

    ColumnLabels <- as.character(ColNames[grepl("mean()", ColNames$V2, fixed=TRUE) | grepl("std()", ColNames$V2, fixed=TRUE), ][["V2"]]) ##Extracts only the column names with mean() and std() in it
    ColumnLabels <- gsub("-", "", tolower(ColumnLabels)) ##Made all column names lower case and removed "-"
    ColumnLabels <- gsub("\\(", "", ColumnLabels) ##Removed "(" from column names
    ColumnLabels <- gsub("\\)", "", ColumnLabels) ##Removed ")" from column names
    colnames(x) <- c("label", "volunteer", ColumnLabels, "activitydesc") ##Added column names to the data set
    x <- x[,c(2, 69, 3:68)] ##Removed activity label code column from the data set and rearrange columns to make column with descriptive activity names 2nd column
    
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject (volunteer)

    xMelt <- melt(x,id=c("volunteer","activitydesc"),measure.vars=c(3:68)) ##Melt data set using "volunteer" and "activitydesc" columns as ID columns
    xTidyLong <- aggregate(. ~ volunteer + activitydesc + variable, xMelt, FUN = "mean") ##Calculate mean for each variable by activity and each volunteer
    write.table(xTidyLong, file = "TidyDataLong.txt", sep="\t", row.names = FALSE) ##Save data to the text file
    
    This part of code generates a long tidy data text file that meets the principles of tidy data described in Hadley Wickham's paper

