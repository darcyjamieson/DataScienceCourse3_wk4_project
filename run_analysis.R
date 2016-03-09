## The run_analysis.R script will do the following:
## 0. Download and extract the files locally.
## 1. Merge the training and the test sets to create one measurement data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(dplyr)


## download and extract data

if(!file.exists("./data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile = "./data/temp.zip")
unzip("./data/temp.zip",exdir="./data")
unlink("./data/temp.zip")

## load and merge the datasets
basepath<-file.path(".","data","UCI HAR DATASET")

activity_labels<-read.table(file.path(basepath,"activity_labels.txt"),header = FALSE)
names(activity_labels)<-c("id","activity")

features<-read.table(file.path(basepath,"features.txt"),header = FALSE)

subject_train<-read.table(file.path(basepath,"train","subject_train.txt"),header = FALSE)
subject_test<-read.table(file.path(basepath,"test","subject_test.txt"),header = FALSE)
subjects<-rbind(subject_train,subject_test)
names(subjects)<-c("subject")
subjects$subject<-as.factor(subjects$subject)

X_train<-read.table(file.path(basepath,"train","X_train.txt"),header = FALSE)
X_test<-read.table(file.path(basepath,"test","X_test.txt"),header = FALSE)
data_tbl<-rbind(X_train,X_test)
names(data_tbl)<-features$V2

y_train<-read.table(file.path(basepath,"train","y_train.txt"),header = FALSE)
y_test<-read.table(file.path(basepath,"test","y_test.txt"),header = FALSE)
labels_tbl<-rbind(y_train,y_test)
names(labels_tbl)<-c("activity")


## clean up workspace by removing the large intermediate datasets:
rm(list=c("subject_train","subject_test","X_train","X_test","y_train","y_test"))


## Extract mean and SD for time domain Gravity and Body, Gyro and Acc data (eg. only measured data)
data_tbl<-data_tbl[,grepl("^t(Body|Gravity)(Gyro|Acc)\\-(mean|std)\\(\\)\\-(X|Y|Z)",names(data_tbl))]


## replace activity ids to create descriptive names based on activity_labels data
labels_tbl<-data.frame(activity=activity_labels[match(labels_tbl$activity,activity_labels$id),2])


## rename data to create descriptive labels
names(data_tbl)<-tolower(gsub("t(Body|Gravity)(Gyro|Acc)\\-(mean|std)\\(\\)-(X|Y|Z)","\\1\\2\\3\\4",names(data_tbl)))


## create tidy data containing the mean value for each variable, grouped by subject and activity.
data_tidy<-bind_cols(subjects,labels_tbl,data_tbl) %>%
     group_by(subject,activity) %>%
     summarise_each(funs(mean))


## write to a csv file
write.csv(data_tidy,file="./AveActivityMeas.csv",quote=FALSE,row.names=FALSE)

## Tidy up remaining datasets:
rm(list=c("activity_labels","features","labels_tbl","subjects"))
