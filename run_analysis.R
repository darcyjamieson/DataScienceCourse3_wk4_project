## The run_analysis.R script will do the following:
## 0. Check that the files are available locally in the current working directory or any subfolders.
## 1. Merge the training and the test sets to create one measurement data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

require(dplyr)


## Check and get the location for each required file.

filenames<-data.frame(names=c("activity_labels.txt",
	"features.txt",
	"subject_train.txt",
	"subject_test.txt",
	"X_train.txt",
	"X_test.txt",
	"y_train.txt",
	"y_test.txt"
	))

chkfullpath<-function(file){
     fullname<-list.files(pattern=as.character(paste0("^",file)),full.names=TRUE,recursive=TRUE,ignore.case=TRUE)
     if(length(fullname)==0){
          stop("Required raw data file missing: ",file)
     } else {
          fullname[[1]]
     }
}

filenames$fullname<-lapply(filenames$names,chkfullpath)


## load and merge the datasets


activity_labels<-read.table(filenames$fullname[[1]],header = FALSE)
names(activity_labels)<-c("id","activity")

features<-read.table(filenames$fullname[[2]],header = FALSE)

subject_train<-read.table(filenames$fullname[[3]],header = FALSE)
subject_test<-read.table(filenames$fullname[[4]],header = FALSE)
subjects<-rbind(subject_train,subject_test)
names(subjects)<-c("subject")
subjects$subject<-as.factor(subjects$subject)

X_train<-read.table(filenames$fullname[[5]],header = FALSE)
X_test<-read.table(filenames$fullname[[6]],header = FALSE)
data_tbl<-rbind(X_train,X_test)
names(data_tbl)<-features$V2

y_train<-read.table(filenames$fullname[[7]],header = FALSE)
y_test<-read.table(filenames$fullname[[8]],header = FALSE)
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


## write to a txt file
write.table(data_tidy,file="./AveActivityMeasOutput.txt",quote=FALSE,row.names=FALSE)

## Tidy up remaining datasets:
rm(list=c("filenames","activity_labels","features","labels_tbl","subjects"))
