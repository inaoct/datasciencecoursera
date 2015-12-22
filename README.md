#This file describes the steps to take to produce a tidy data set conforming to the requirements of the  Coursera's Getting and Cleaning Data Course Project

1. Download the data set from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip] and extract it into R's working directory
2. Rename the top-level directory to replace space with underscore. The renamed directory should be called UCI_HAR_Dataset 
3. The R script utilized for the processing of the data set requires the dplyr package. If you do not have the package, install it by running install.packages("dplyr") and then load the package by running library(dplyr)
4. Only one script, named run_analysis.R, is used to process the data and produce the required tidy data set. Download the script to your R working directory and run it by executing the command source("run_analysis.R")
5. The script will write out statements indicating execution progress
5. The script will produce a file called tidy_results.txt and place the file in the UCI_HAR_Dataset directory. This is the desired tidy data set.