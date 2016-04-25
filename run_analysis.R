## Course Project for Getting and Cleaning Data course
##This R script is called run_analysis.R. It collects, cleans a data set and finally prepares tidy data that can be used for later analysis. 
##Data set represents the data collected from the accelerometers from the Samsung Galaxy S smartphone. 
##More detailed description is available in README.md and Code Book (CodeBook.md) for this assighment. 

library(reshape2)
library(data.table)

##Dowload, unzip and delete original data archive
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "Dataset.zip", method = "curl")
unzip("Dataset.zip")
unlink("Dataset.zip")

##Load train data set
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

##Load test data set
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

##Load column names and acitivity labels
ColNames <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
Activity_Labels <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
colnames(Activity_Labels) <- c("label", "activitydesc")

##1. Merges the training and the test sets to create one data set
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
colnames(y) <- c("label")
subject <- rbind(subject_train, subject_test)
subject$V1 <- as.factor(subject$V1)
colnames(subject) <- c("volunteer")

##Release memory space from train and test data.frames
x_train <-NULL; x_test <- NULL; y_train <- NULL; y_test <- NULL; subject_train <- NULL; subject_test <- NULL

##2. Extracts only the measurements on the mean - mean() and standard deviation - std() for each measurement
x <- x[grepl("mean()", ColNames$V2, fixed=TRUE) | grepl("std()", ColNames$V2, fixed=TRUE)]
x <- cbind(subject, y, x)

##3. Uses descriptive activity names to name the activities in the data set
x = merge(x,Activity_Labels,by="label",all.x=TRUE)
x$activitydesc <- as.factor(x$activitydesc)


##4. Appropriately labels the data set with descriptive variable names
ColumnLabels <- as.character(ColNames[grepl("mean()", ColNames$V2, fixed=TRUE) | grepl("std()", ColNames$V2, fixed=TRUE), ][["V2"]])
ColumnLabels <- gsub("-", "", tolower(ColumnLabels))
ColumnLabels <- gsub("\\(", "", ColumnLabels)
ColumnLabels <- gsub("\\)", "", ColumnLabels)
colnames(x) <- c("label", "volunteer", ColumnLabels, "activitydesc")
x <- x[,c(2, 69, 3:68)]

##5. From the data set in step 4, creates a second, independent tidy data set 
##with the average of each variable for each activity and each subject
xMelt <- melt(x,id=c("volunteer","activitydesc"),measure.vars=c(3:68))
xTidyLong <- aggregate(. ~ volunteer + activitydesc + variable, xMelt, FUN = "mean")
write.table(xTidyLong, file = "TidyDataLong.txt", sep="\t", row.names = FALSE)

##Section of the code to produce wide tidy data set if needed. Currently disabled.
##xTidyWide <- dcast(xMelt, volunteer + activitydesc ~ variable,mean)
##write.table(xTidyWide, file = "TidyData.txt", sep="\t", row.names = FALSE)
