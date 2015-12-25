## This script assumes that the source data file from 
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
## is downloaded and extracted into R's working directory. 
## Additionally, the top level directory after extraction needs to be renamed to UCI_HAR_Dataset. 
## The renaming removes white spaces in the directory name and replaces them with underscores.

## Load the dplyrt package. 
require(dplyr)

## Extract variable names 
varNames <- read.table("./UCI_HAR_Dataset/features.txt", sep = "")
columnHeadings <- varNames[, 2]

## Extract TEST data and load each file (measurements, subjects, activities) into separate data frames.
## Upon loading, add descriptive variable names as the initial data set contains no headings.
print("Reading TEST data")
testData <- read.table("./UCI_HAR_Dataset/test/X_test.txt", sep = "", col.names = columnHeadings, check.names = FALSE)
subjectTestData <- read.table("./UCI_HAR_Dataset/test/subject_test.txt", sep = "", col.names = c("Subject"))
labelsTestData <- read.table("./UCI_HAR_Dataset/test/y_test.txt", sep = "", col.names = c("Activity"), 
                             colClasses = c("character"))

## Extract TRAINING data and load each file (measurements, subjects, activities) into separate data frames.
## Upon loading, add descriptive variable names as the initial data set contains no headings.
print("Reading TRAINING data")
trainData <- read.table("./UCI_HAR_Dataset/train/X_train.txt", sep = "", col.names = columnHeadings, check.names = FALSE)
subjectTrainData <- read.table("./UCI_HAR_Dataset/train/subject_train.txt", sep = "", col.names = c("Subject"))
labelsTrainData <- read.table("./UCI_HAR_Dataset/train/y_train.txt", sep = "", col.names = c("Activity"),
                              , colClasses = c("character"))

## Combine subject, activity, and measuremetns into one data frame.
## TEST and TRAINING data are still separate
testData <- bind_cols(subjectTestData, labelsTestData, testData)
trainData <- bind_cols(subjectTrainData, labelsTrainData, trainData)

## Combine TESTING and TRAINING data
allData <- bind_rows(testData, trainData)

## Extract only mean and standard deviation measurement data
print("Producing TIDY data set")
meanAndStdData <- select(allData, matches("-mean()|-std()|Activity|Subject"))
## Replace activity codes with descriptive names. 
## NOTE: The command below is fairly cumbersome. TODO: Is there a more succinct way to perform the same action?
revisedData <- meanAndStdData %>%
  mutate(Activity = ifelse(Activity == "1", "WALKING", Activity)) %>%
  mutate(Activity = ifelse(Activity == "2", "WALKING_UPSTAIRS", Activity)) %>%
  mutate(Activity = ifelse(Activity == "3", "WALKING_DOWNSTAIRS", Activity)) %>%
  mutate(Activity = ifelse(Activity == "4", "SITTING", Activity)) %>%
  mutate(Activity = ifelse(Activity == "5", "STANDING", Activity)) %>%
  mutate(Activity = ifelse(Activity == "6", "LAYING", Activity))

## Prepare to compute average by activity & subject 
## Group data by subject and activity so that summarize() can be applied for these groupings
groupedData <- group_by(revisedData, Activity, Subject) 
## Apply mean() to each column. Summarize() takes care of performing the mean for the defined groups
tidyData <- summarize_each(groupedData, funs(mean)) 
## Sort the results by subject, and then by activity
sortedData <- arrange(tidyData, Subject, Activity)

## Write the result into a file
write.table(sortedData, file = "./UCI_HAR_Dataset/tidy_results.txt", row.names = FALSE)
print("DONE")

