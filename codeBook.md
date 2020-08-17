The script entitled "run_analysis.R" shows the code of data processing based on the order of the projects in the course. 

0. Preparation.
First, load the library of dplyr for the later use: process the data.
Second, set the working directory.
Third, download the dataset into the folder "Week-4-Project-Run-Analysis" if the data file does not exist in this folder. 
Fouth, extract the data into the folder named "UCI HAR Dataset" if files do not exist.

1. Merges the training and the test sets to create one data set. Use dim () function to evaluate the number of rows and columns.
First, load the feature file (features.txt) to get all the features. Then load x_train.txt, y_train.txt, x_test.txt, and y_test.txt, and assign each data set variables.  
(1) feature: from features.txt with 561 rows and 2 columns. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.

(2) x_train: from train/X_train.txt with 7352 rows and 561 columns, which contains features in the training data set.
    y_train: from train/y_train.txt with 7352 rows and 1 columns, which contains the dependent variable of code in the training data set.
    x_test: from test/X_test.txt with 2947 rows and 561 columns, which contains features in the test data set.
    y_test <- test/y_test.txt with 2947 rows and 1 columns, which contains the dependent variable of code in the test data set.

(3) merge the training and the test sets to create one data set
    x: merging x_train and x_test using rbind() function, which yields 10299 rows and 561 columns
    y: merging y_train and y_test using rbind() function, which yields 10299 rows and 1 column.
    subjectTrain: from train/subject_train.txt with 7352 rows and 1 column and 21 of 30 subjects in the experiment.
    subjectTest: from test/subject_test.txt with 2947 rows and 1 column and 9 of 30 subjects in the experiment.
    subject: merging subjectTrain and subjectTest using rbind() function, which yields 10299 rows and 1 column.
    allData: merging subject, y, and X using cbind() function, which yields 10299 rows and 563 column.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
From the allData from 1., create tidyData1 using select () function to subset columns including subject, label, each variable whose names contain the "mean" and "std" (standard deviation) for each measurement. tidyData1 has 10299 rows and 88 columns.

3. Uses descriptive activity names to name the activities in the data set.
(1) activity: from activity_labels.txt with 6 rows and 2 columns, which lists the class labels (label) with activity names (activities). 
(2) replace the class labels in tidyData1 in the 2th column with their corresponding activity names in the 2nd column of the activity data set.
(3) rename the label column in tidyData1 into activity.

4. Appropriately labels the data set with descriptive variable names.
(1) Use names() function to look at the variable names.
(2) Use gsub() function to replace all inappropriate names into appropriate names:
    A. Change "t" and "f" in the beginning of column names into full names "Time" and "Frequency."
       Change "tBody" in the middle into "TimeBody."
    B. Replace the acronyms by full forms: Acc by "Accelerometer", "Gyro" by "Gyroscope", and "Mag" by "Magnitude."
    C. Remove the repeated words of "BodyBody" by "Body"
    D. Change the lower case into upper case in the first letter to keep the consistency.
    E. Change "mean/std/freq" into "Mean/STD/Frequency."
(3) Use names() function to check the variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
From tidyData1 in 4., create tidyData2 using group_by() function for each subject and each activity, and then using summarize_all() function to summarize the data with the mean for each subject and each activity (list(mean = mean).

tidyData2 has 180 rows and 88 columns. The data set is saved into tidyData2.txt. Columns names include:
[1] "subject"                                                          
 [2] "activity"                                                         
 [3] "TimeBodyAccelerometer.Mean...X_mean"                              
 [4] "TimeBodyAccelerometer.Mean...Y_mean"                              
 [5] "TimeBodyAccelerometer.Mean...Z_mean"                              
 [6] "TimeGravityAccelerometer.Mean...X_mean"                           
 [7] "TimeGravityAccelerometer.Mean...Y_mean"                           
 [8] "TimeGravityAccelerometer.Mean...Z_mean"                           
 [9] "TimeBodyAccelerometerJerk.Mean...X_mean"                          
[10] "TimeBodyAccelerometerJerk.Mean...Y_mean"                          
[11] "TimeBodyAccelerometerJerk.Mean...Z_mean"                          
[12] "TimeBodyGyroscope.Mean...X_mean"                                  
[13] "TimeBodyGyroscope.Mean...Y_mean"                                  
[14] "TimeBodyGyroscope.Mean...Z_mean"                                  
[15] "TimeBodyGyroscopeJerk.Mean...X_mean"                              
[16] "TimeBodyGyroscopeJerk.Mean...Y_mean"                              
[17] "TimeBodyGyroscopeJerk.Mean...Z_mean"                              
[18] "TimeBodyAccelerometerMagnitude.Mean.._mean"                       
[19] "TimeGravityAccelerometerMagnitude.Mean.._mean"                    
[20] "TimeBodyAccelerometerJerkMagnitude.Mean.._mean"                   
[21] "TimeBodyGyroscopeMagnitude.Mean.._mean"                           
[22] "TimeBodyGyroscopeJerkMagnitude.Mean.._mean"                       
[23] "FrequencyuencyBodyAccelerometer.Mean...X_mean"                    
[24] "FrequencyuencyBodyAccelerometer.Mean...Y_mean"                    
[25] "FrequencyuencyBodyAccelerometer.Mean...Z_mean"                    
[26] "FrequencyuencyBodyAccelerometer.MeanFrequency...X_mean"           
[27] "FrequencyuencyBodyAccelerometer.MeanFrequency...Y_mean"           
[28] "FrequencyuencyBodyAccelerometer.MeanFrequency...Z_mean"           
[29] "FrequencyuencyBodyAccelerometerJerk.Mean...X_mean"                
[30] "FrequencyuencyBodyAccelerometerJerk.Mean...Y_mean"                
[31] "FrequencyuencyBodyAccelerometerJerk.Mean...Z_mean"                
[32] "FrequencyuencyBodyAccelerometerJerk.MeanFrequency...X_mean"       
[33] "FrequencyuencyBodyAccelerometerJerk.MeanFrequency...Y_mean"       
[34] "FrequencyuencyBodyAccelerometerJerk.MeanFrequency...Z_mean"       
[35] "FrequencyuencyBodyGyroscope.Mean...X_mean"                        
[36] "FrequencyuencyBodyGyroscope.Mean...Y_mean"                        
[37] "FrequencyuencyBodyGyroscope.Mean...Z_mean"                        
[38] "FrequencyuencyBodyGyroscope.MeanFrequency...X_mean"               
[39] "FrequencyuencyBodyGyroscope.MeanFrequency...Y_mean"               
[40] "FrequencyuencyBodyGyroscope.MeanFrequency...Z_mean"               
[41] "FrequencyuencyBodyAccelerometerMagnitude.Mean.._mean"             
[42] "FrequencyuencyBodyAccelerometerMagnitude.MeanFrequency.._mean"    
[43] "FrequencyuencyBodyAccelerometerJerkMagnitude.Mean.._mean"         
[44] "FrequencyuencyBodyAccelerometerJerkMagnitude.MeanFrequency.._mean"
[45] "FrequencyuencyBodyGyroscopeMagnitude.Mean.._mean"                 
[46] "FrequencyuencyBodyGyroscopeMagnitude.MeanFrequency.._mean"        
[47] "FrequencyuencyBodyGyroscopeJerkMagnitude.Mean.._mean"             
[48] "FrequencyuencyBodyGyroscopeJerkMagnitude.MeanFrequency.._mean"    
[49] "Angle.TimeBodyAccelerometerMean.Gravity._mean"                    
[50] "Angle.TimeBodyAccelerometerJerkMean..GravityMean._mean"           
[51] "Angle.TimeBodyGyroscopeMean.GravityMean._mean"                    
[52] "Angle.TimeBodyGyroscopeJerkMean.GravityMean._mean"                
[53] "Angle.X.GravityMean._mean"                                        
[54] "Angle.Y.GravityMean._mean"                                        
[55] "Angle.Z.GravityMean._mean"                                        
[56] "TimeBodyAccelerometer.STD...X_mean"                               
[57] "TimeBodyAccelerometer.STD...Y_mean"                               
[58] "TimeBodyAccelerometer.STD...Z_mean"                               
[59] "TimeGravityAccelerometer.STD...X_mean"                            
[60] "TimeGravityAccelerometer.STD...Y_mean"                            
[61] "TimeGravityAccelerometer.STD...Z_mean"                            
[62] "TimeBodyAccelerometerJerk.STD...X_mean"                           
[63] "TimeBodyAccelerometerJerk.STD...Y_mean"                           
[64] "TimeBodyAccelerometerJerk.STD...Z_mean"                           
[65] "TimeBodyGyroscope.STD...X_mean"                                   
[66] "TimeBodyGyroscope.STD...Y_mean"                                   
[67] "TimeBodyGyroscope.STD...Z_mean"                                   
[68] "TimeBodyGyroscopeJerk.STD...X_mean"                               
[69] "TimeBodyGyroscopeJerk.STD...Y_mean"                               
[70] "TimeBodyGyroscopeJerk.STD...Z_mean"                               
[71] "TimeBodyAccelerometerMagnitude.STD.._mean"                        
[72] "TimeGravityAccelerometerMagnitude.STD.._mean"                     
[73] "TimeBodyAccelerometerJerkMagnitude.STD.._mean"                    
[74] "TimeBodyGyroscopeMagnitude.STD.._mean"                            
[75] "TimeBodyGyroscopeJerkMagnitude.STD.._mean"                        
[76] "FrequencyuencyBodyAccelerometer.STD...X_mean"                     
[77] "FrequencyuencyBodyAccelerometer.STD...Y_mean"                     
[78] "FrequencyuencyBodyAccelerometer.STD...Z_mean"                     
[79] "FrequencyuencyBodyAccelerometerJerk.STD...X_mean"                 
[80] "FrequencyuencyBodyAccelerometerJerk.STD...Y_mean"                 
[81] "FrequencyuencyBodyAccelerometerJerk.STD...Z_mean"                 
[82] "FrequencyuencyBodyGyroscope.STD...X_mean"                         
[83] "FrequencyuencyBodyGyroscope.STD...Y_mean"                         
[84] "FrequencyuencyBodyGyroscope.STD...Z_mean"                         
[85] "FrequencyuencyBodyAccelerometerMagnitude.STD.._mean"              
[86] "FrequencyuencyBodyAccelerometerJerkMagnitude.STD.._mean"          
[87] "FrequencyuencyBodyGyroscopeMagnitude.STD.._mean"                  
[88] "FrequencyuencyBodyGyroscopeJerkMagnitude.STD.._mean" 
