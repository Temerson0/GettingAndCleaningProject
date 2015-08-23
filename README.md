---
title: "ReadMe"
author: "Tim Emerson"
date: "August 23, 2015"
output: html_document
---

This file describes the implementation of the Getting and Cleaning Data Course Project.  

The data for the project can be retrieved from the following source:  
[Link]https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

R code is included in the following file:  
**run_analysis.R**  
  
The run_analysis.R script performs the following:     

1. Merge the training and the test sets to create one data set.  
     
    * x and y for training and test were merged.  
    
2. Extracts only the measurements on the mean and standard deviation for each measurement. 

    * This results in 53 mean features and 33 standard deviation features.   
    
3. Added a column for acitvity and used the following descriptive activity names are used in the data set. 

    * WALKING  
    
    * WALKING_UPSTAIRS    
    
    * WALKING_DOWNSTAIRS  
    
    * SITTING  
    
    * STANDING  
    
    * LAYING  
    
4. Labeled the data set with descriptive variable names.  

    * The variable names were taken from the **feature.txt** file.  
    
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

    * This was performed with a group_by, summarize operation from dplyr.  
   
    * Note: This is a wide representation of the original dataset in a tidy format.