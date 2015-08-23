# run_analysis.R
# 
# This R script will analyze the UCI Human Activity Recognition Using Smartphones Dataset.

library(data.table)
library(dplyr)

# Part 1- Read all datasets that will be merged into one dataset.
xtest <- read.table("X_test.txt")
ytest <- read.table("Y_test.txt")
subtest <- read.table("subject_test.txt")
xtrain <- read.table("X_train.txt")
ytrain <- read.table("Y_train.txt")
subtrain <- read.table("subject_train.txt")

# Part 4
# Add the column names to the data. Use the features.txt file.
features <- readLines("features.txt")
names(xtest) <- features
names(xtrain) <- features
names(ytest) <- "Activity"
names(ytrain) <- "Activity"
names(subtest) <- "Subject"
names(subtrain) <- "Subject"

# Part 1 continuation - Perform merge training, test and subject datasets into one.
test <- cbind(xtest,subtest,ytest)
train <- cbind(xtrain,subtrain,ytrain)
mergedData <- rbind(train, test)

# Part 2 - Extract only features with Mean and Standard Deviation.
mean_cols <- select(mergedData,contains("mean"))        # Select only features with mean.
std_cols <- select(mergedData,contains("Std"))          # Select only features with Std.
# Keep only mean, Std, subject and activity features.
meanStdData <- cbind(mean_cols,std_cols,Subject=mergedData$Subject,Activity=mergedData$Activity)
mdt <- tbl_df(meanStdData)

# Part 3
# Use descriptive activity names for the Y labels
mdt[mdt[,"Activity"]==1,"Activity"] = "WALKING"
mdt[mdt[,"Activity"]==2,"Activity"] = "WALKING_UPSTAIRS"
mdt[mdt[,"Activity"]==3,"Activity"] = "WALKING_DOWNSTAIRS"
mdt[mdt[,"Activity"]==4,"Activity"] = "SITTING"
mdt[mdt[,"Activity"]==5,"Activity"] = "STANDING"
mdt[mdt[,"Activity"]==6,"Activity"] = "LAYING"

# Part 5 - Tidy dataset - This is a wide representation
tidyData <- mdt %>%
    dplyr::group_by(Subject,Activity) %>%      # Group by subject and activity
    dplyr::summarise_each(funs(mean))           # Calculate Mean for each subject and activity

write.table(tidyData,file = "tidyData.txt",row.name = FALSE)
