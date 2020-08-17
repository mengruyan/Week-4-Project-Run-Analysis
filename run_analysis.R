### Project: Getting and Cleaning Data

## load library
library(dplyr)

## set working directory: You should change to your own working directory.
setwd("G:\\ZZZ_New\\Coursera_DataScience_Specialization\\datasciencecoursera\\Week-4-Project-Run-Analysis")

## check whether the required data set exists. If not, download it.
dataName <- "getdata_projectfiles_UCI HAR Dataset.zip"

if(!file.exists(fileName)){
    dataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(dataURL, dataName, method = "curl")
} else {
  "Downloaded"
}


## check whether UCI HAR Dataset folder exists. If not, unzip the zipped data
if (!file.exists("UCI HAR Dataset")) {
    unzip(dataName)
} else {
    print("Found")
}

# 1. Merges the training and the test sets to create one data set.
## load the feature file to get all the features
feature <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","features"))

## load the training set x and training labels
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature$features)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "label")

## count the rows and columns in the training data set
dim(x_train)
dim(y_train)

## load the test set x and test labels
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feature$features)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "label")

dim(x_test)
dim(y_test)

## merge the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)

dim(X)
dim(y)


## get subject data in the training and test data sets.
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

dim(subjectTrain)
dim(subjectTest)

## merge subject data in both training and test data sets by rows
subject <- rbind(subjectTrain, subjectTest)
dim(subject)

## merge subject data, X, and y into one data set.
allData <- cbind(subject, y, X)

dim(allData)

View(allData) # view the data set

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
tidyData1 <- allData %>% select(subject, label, contains("mean"), contains("std"))

dim(tidyData1)

names(tidyData1) ## check variable names

# 3. Uses descriptive activity names to name the activities in the data set
## get activity data
activity <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("label", "activities"))

tidyData1$label <- activity[tidyData1$label, 2]

## change "label" to "activity" 
names(tidyData1)[2] = "activity"

tidyData1$activity ## check results


# 4. Appropriately labels the data set with descriptive variable names.
## get the current variable names
names(tidyData1)

## use gsub to replaces all matches of a string
##### A. change "t" and "f" at the beginning into full names
names(tidyData1)<-gsub("^t", "Time", names(tidyData1))
names(tidyData1)<-gsub("^f", "Frequency", names(tidyData1))

##### A.1 change tBody in the middle into TimeBody
names(tidyData1)<-gsub("tBody", "TimeBody", names(tidyData1))


##### B. replace the acronyms into full forms, 
names(tidyData1)<-gsub("Acc", "Accelerometer", names(tidyData1))
names(tidyData1)<-gsub("Gyro", "Gyroscope", names(tidyData1))
names(tidyData1)<-gsub("Mag", "Magnitude", names(tidyData1))


##### C. remove the repeated words
names(tidyData1)<-gsub("BodyBody", "Body", names(tidyData1))

##### D. change the lower case into upper case in the first letter 
names(tidyData1)<-gsub("angle", "Angle", names(tidyData1))
names(tidyData1)<-gsub("gravity", "Gravity", names(tidyData1))

##### E. change mean, std, freq
names(tidyData1)<-gsub("mean()", "Mean", names(tidyData1), ignore.case = TRUE)
names(tidyData1)<-gsub("std()", "STD", names(tidyData1), ignore.case = TRUE)
names(tidyData1)<-gsub("freq()", "Frequency", names(tidyData1), ignore.case = TRUE)

names(tidyData1) ## check results

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyData2 <- tidyData1 %>%
  group_by(subject, activity) %>%
  summarise_all(list(mean = mean))

View(tidyData2) ## check results
dim(tidyData2)
## save the results
write.table(tidyData2, "tidyData2.txt", row.name=FALSE)
