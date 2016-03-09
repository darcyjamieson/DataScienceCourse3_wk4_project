### Summary of folder
This folder contains the following for week4 project sumbission to 
Coursera course Getting and Cleaning Data:
* a tidy data set (AveActivityMeas.txt) with the average of each variable for each activity and each subject.
* a script (run_analysis.R) for performing the analysis including downloading, transforming and creating the tidy dataset.
* A code book (CodeBook.md) that describes the variables, the data and any transformations or work that was performed to clean up the data.


### Script summary
Only one script is used for this analysis.

The script requires the R package "dplyr".

The raw data must already be downloaded and unzipped into the "UCI HAR Dataset" subfolder in the working directory.

Sourcing the script (run_analysis.R) in R, will
* check that the raw data is in the folder "UCI HAR Dataset", 
* perform the detailed transformations defined in the CodeBook and 
* output a tidy dataset file (AveActivityMeasOutput.txt) in the working directory. This will have the same data as can be found in the provided text file for comparison (AveActivityMeas.txt).


### Notes:
The data used in this script was collected from a study using the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

