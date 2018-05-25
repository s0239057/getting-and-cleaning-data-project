library(dplyr)

# download and unzip the data

if(!file.exists("./data")){dir.create("./data")}
fileURL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL1, destfile = "./data/dataset.zip")

unzip(zipfile="./data/dataset.zip",exdir="./data")

# read data in tables

path_data <- file.path("./data" , "UCI HAR Dataset")

activityDataTest  <- read.table(file.path(path_data, "test" , "Y_test.txt" ),header = FALSE)
activityDataTrain  <- read.table(file.path(path_data, "train" , "Y_train.txt" ),header = FALSE)

subjectDataTest  <- read.table(file.path(path_data, "test" , "subject_test.txt" ),header = FALSE)
subjectDataTrain  <- read.table(file.path(path_data, "train" , "subject_train.txt" ),header = FALSE)

XDataTest  <- read.table(file.path(path_data, "test" , "X_test.txt" ),header = FALSE)
XDataTrain  <- read.table(file.path(path_data, "train" , "X_train.txt" ),header = FALSE)

# Merge the training and testing sets for individual datasets

XCombine <- rbind(XDataTrain, XDataTest)
activityCombine <- rbind(activityDataTrain, activityDataTest)
subjectCombine <- rbind(subjectDataTrain, subjectDataTest)

# (1) add descriptive names for the feature variables

featNames <- read.table(file.path("./data" , "UCI HAR Dataset", "features.txt"),header = FALSE)
names(XCombine) <- featNames$V2

# (2) retain the variables with mean and standard deviation

mean_sd_idx <- grep(".*mean.*|.*std.*", featNames$V2)
XCombine_1 <- XCombine[,mean_sd_idx]
feat_retained <- featNames$V2[mean_sd_idx]

# (3) Merge all the data into a single dataset -> order: feature_data, activity, subjects

dataAll_int <- cbind(activityCombine, subjectCombine)
dataAll <- cbind(XCombine_1, dataAll_int)

# remove previous variables

rm(activityDataTest,activityDataTrain,subjectDataTest,subjectDataTrain,XDataTest,XDataTrain)

# tidy up the variable names

feat_retained = gsub('-mean', 'Mean', feat_retained)
feat_retained = gsub('-std', 'Std', feat_retained)
feat_retained <- gsub('[-()]', '', feat_retained)

# (4) Update dataAll colnames and add activity labels to the dataset

activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("ActivityID", "ActivityLabel")

colnames(dataAll) <- c(feat_retained, "subject", "activity")
dataAll$activity <- factor(dataAll$activity, levels = activity_labels[, 1], labels = activity_labels[, 2])

# (5) group by subject and activity and apply a mean function

total_mean <- dataAll %>% group_by(subject, activity) %>% summarize_all(funs(mean))

write.table(total_mean, "tidy_data.txt", row.names = FALSE, quote = FALSE)