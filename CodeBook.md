
## Study Design
Data was collected from 30 volunteers performing six activities wearing a smartphone on the waist for a particular study.  
This data was made available to download and full details on the study can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data collected and provided from the study consisted of measured signals and derived signals.  
There were two types of measurements: linear acceleration from the accelerometer (Acc) and angular velocity from the gyroscope (Gyro) of which each had three directional components (X, Y, Z). 
The accelerometer measured signals were provided in two components: a Gravity component and a Body component.
The mean and standard deviation of these measurements are the values that were extracted and summarised for analysis using the provided script (run_analysis.R). 

The objective of this script is to take the raw data from the working directory or subfolders containing a combination of text files 
and combine the data into a useful tidy dataset in one space seperated text file (AveActivityMeasOutput.txt).


## Code Book

The following columns are included in the output data set:
* subject: The subject who performed the activity (values range from 1 to 30)
* activity: The activity that the subject was performing (either: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, or LAYING)
* bodyaccmeanx: average Accelerometer mean x value for the body component (units: standard gravity 'g')
* bodyaccmeany: average Accelerometer mean y value for the body component (units: standard gravity 'g')
* bodyaccmeanz: average Accelerometer mean z value for the body component (units: standard gravity 'g')
* bodyaccstdx: average Accelerometer standard deviation x value for the body component (units: standard gravity 'g')
* bodyaccstdy: average Accelerometer standard deviation y value for the body component (units: standard gravity 'g')
* bodyaccstdz: average Accelerometer standard deviation z value for the body component (units: standard gravity 'g')
* gravityaccmeanx: average Accelerometer mean x value for the gravity component (units: standard gravity 'g')
* gravityaccmeany: average Accelerometer mean y value for the gravity component (units: standard gravity 'g')
* gravityaccmeanz: average Accelerometer mean z value for the gravity component (units: standard gravity 'g')
* gravityaccstdx: average Accelerometer standard deviation x value for the gravity component (units: standard gravity 'g')
* gravityaccstdy: average Accelerometer standard deviation y value for the gravity component (units: standard gravity 'g')
* gravityaccstdz: average Accelerometer standard deviation z value for the gravity component (units: standard gravity 'g')
* bodygyromeanx: average Gyroscope mean x value for the body component (units: radians/second)
* bodygyromeany: average Gyroscope mean y value for the body component (units: radians/second)
* bodygyromeanz: average Gyroscope mean z value for the body component (units: radians/second)
* bodygyrostdx: average Gyroscope standard deviation x value for the body component (units: radians/second)
* bodygyrostdy: average Gyroscope standard deviation y value for the body component (units: radians/second)
* bodygyrostdz: average Gyroscope standard deviation z value for the body component (units: radians/second)


## Process

The following transformations were performed to obtain the output dataset:
* check that the data is in the working directory.
* load the individual data files into memory
* merge all the data sets (Train and Test sets) into one data frame
* subset out only the mean and standard deviation of the measurement data (from the Accelerometer and Gyro signals) excluding all of the derived data sets.
* replace the activity id numbers with the appropriate text based on the activity labels provided.
* rename the measurement variable names with descriptive and clean names
* summarise the data by taking the mean of each measurement based on subject and activity to obtain a tidy dataset with the average of each variable for each activity and each subject.
* output this tidy data set to a text (*.txt) file.
* clean up the workspace to remove all but the combined raw data and the tidy datasets.
