# Getting and Cleaning Data 
## Course Project Code Book

### Project Goal
Create a tidy data set from the source data set that provides the average values of mean and standard deviation measurements per subject and activity. During processing ensure that variables and activities are appropriately named. Specifically, the steps as requested in the project were as follows:

1. Merge the training and the test sets to create one data set.  
2. Extract only the measurements on the mean and standard deviation for each measurement.   
3. Use descriptive activity names to name the activities in the data set.  
4. Appropriately label the data set with descriptive variable names.   
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

### Source Data Set
The source data used for this project was downloaded from [Source Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
The data represents accelerometer measuremetns for a set of subject and 6 different activities performed by each subject. Addiitonal details on the experiements that were performed to obtain the data can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### Source Data Processing
The source data was downloaded from the above link and the contents of the zip file were extracted into R's working directory. The name of the top level directory in the zip file was renamed to replace spaces with underscores to avoid issues with file references. As a result, all data files could be found in R's working directory under the UCI_HAR_Dataset directory.

The data set contains multiple files but not all files were needed for the task at hand. Specifically, the following data files were utilized:
* ./UCI_HAR_Dataset/features.txt was used to retrieve all variable names 
* ./UCI_HAR_Dataset/activity_labels.txt was used to map the activity codes in the data set to descriptive activity labels
* ./UCI_HAR_Dataset/test/X_test.txt was used to load all TEST data
* ./UCI_HAR_Dataset/test/subject_test.txt was used to load all subject data corresponding to the test data. Each line item in this file corresponds to one line item in the TEST data set and identifies the subject used to perform the respective TEST measurement
* ./UCI_HAR_Dataset/test/y_test.txt was used to load all activity data corresponding to the test data. Each line item in this file corresponds to one line item in the TEST data set and identifies the activity represented by the respective TEST measurement
* ./UCI_HAR_Dataset/train/X_train.txt was used to load all TRAINING data
* ./UCI_HAR_Dataset/train/subject_train.txt was used to load all subject data corresponding to the training data. Each line item in this file corresponds to one line item in the TRAINING data set and identifies the subject used to perform the respective TRAINING measurement
* ./UCI_HAR_Dataset/train/y_train.txt as used to load all activity data corresponding to the training data. Each line item in this file corresponds to one line item in the TRAINING data set and identifies the activity represented by the respective TRAINING measurement

## Resulting Data Set
The results of the processing were stored in a file named tidy_results.txt placed in the same top level directory "UCI_HAR_Dataset" as the source files.
The resulting date set contains the following variables:
* Activity 
* Subject
* 79 other variables from the initial data set that represent either mean or standard deviation cacluations on the initial measurements. The value in each of these columns represents the average of the measurement per activity and subject.

The names of the variables are as follows:

 [1] "Activity"                       
 [2] "Subject"                        
 [3] "tBodyAcc-mean()-X"              
 [4] "tBodyAcc-mean()-Y"              
 [5] "tBodyAcc-mean()-Z"              
 [6] "tBodyAcc-std()-X"               
 [7] "tBodyAcc-std()-Y"               
 [8] "tBodyAcc-std()-Z"               
 [9] "tGravityAcc-mean()-X"           
[10] "tGravityAcc-mean()-Y"           
[11] "tGravityAcc-mean()-Z"           
[12] "tGravityAcc-std()-X"            
[13] "tGravityAcc-std()-Y"            
[14] "tGravityAcc-std()-Z"            
[15] "tBodyAccJerk-mean()-X"          
[16] "tBodyAccJerk-mean()-Y"          
[17] "tBodyAccJerk-mean()-Z"          
[18] "tBodyAccJerk-std()-X"           
[19] "tBodyAccJerk-std()-Y"           
[20] "tBodyAccJerk-std()-Z"           
[21] "tBodyGyro-mean()-X"             
[22] "tBodyGyro-mean()-Y"             
[23] "tBodyGyro-mean()-Z"             
[24] "tBodyGyro-std()-X"              
[25] "tBodyGyro-std()-Y"              
[26] "tBodyGyro-std()-Z"              
[27] "tBodyGyroJerk-mean()-X"         
[28] "tBodyGyroJerk-mean()-Y"         
[29] "tBodyGyroJerk-mean()-Z"         
[30] "tBodyGyroJerk-std()-X"          
[31] "tBodyGyroJerk-std()-Y"          
[32] "tBodyGyroJerk-std()-Z"          
[33] "tBodyAccMag-mean()"             
[34] "tBodyAccMag-std()"              
[35] "tGravityAccMag-mean()"          
[36] "tGravityAccMag-std()"           
[37] "tBodyAccJerkMag-mean()"         
[38] "tBodyAccJerkMag-std()"          
[39] "tBodyGyroMag-mean()"            
[40] "tBodyGyroMag-std()"             
[41] "tBodyGyroJerkMag-mean()"        
[42] "tBodyGyroJerkMag-std()"         
[43] "fBodyAcc-mean()-X"              
[44] "fBodyAcc-mean()-Y"              
[45] "fBodyAcc-mean()-Z"              
[46] "fBodyAcc-std()-X"               
[47] "fBodyAcc-std()-Y"               
[48] "fBodyAcc-std()-Z"               
[49] "fBodyAcc-meanFreq()-X"          
[50] "fBodyAcc-meanFreq()-Y"          
[51] "fBodyAcc-meanFreq()-Z"          
[52] "fBodyAccJerk-mean()-X"          
[53] "fBodyAccJerk-mean()-Y"          
[54] "fBodyAccJerk-mean()-Z"          
[55] "fBodyAccJerk-std()-X"           
[56] "fBodyAccJerk-std()-Y"           
[57] "fBodyAccJerk-std()-Z"           
[58] "fBodyAccJerk-meanFreq()-X"      
[59] "fBodyAccJerk-meanFreq()-Y"      
[60] "fBodyAccJerk-meanFreq()-Z"      
[61] "fBodyGyro-mean()-X"             
[62] "fBodyGyro-mean()-Y"             
[63] "fBodyGyro-mean()-Z"             
[64] "fBodyGyro-std()-X"              
[65] "fBodyGyro-std()-Y"              
[66] "fBodyGyro-std()-Z"              
[67] "fBodyGyro-meanFreq()-X"         
[68] "fBodyGyro-meanFreq()-Y"         
[69] "fBodyGyro-meanFreq()-Z"         
[70] "fBodyAccMag-mean()"             
[71] "fBodyAccMag-std()"              
[72] "fBodyAccMag-meanFreq()"         
[73] "fBodyBodyAccJerkMag-mean()"     
[74] "fBodyBodyAccJerkMag-std()"      
[75] "fBodyBodyAccJerkMag-meanFreq()" 
[76] "fBodyBodyGyroMag-mean()"        
[77] "fBodyBodyGyroMag-std()"         
[78] "fBodyBodyGyroMag-meanFreq()"    
[79] "fBodyBodyGyroJerkMag-mean()"    
[80] "fBodyBodyGyroJerkMag-std()"     
[81] "fBodyBodyGyroJerkMag-meanFreq()"
