GettingData Peer assignment
===========================
This repo contains the data analysis performed for peer assignment for Getting and cleaning data in Data Science specialization.

The script run_analysis.R works in this way:

First, we have to read all files:


features.txt has all 561 column names for dataset  
`features <- read.table('UCI HAR Dataset/features.txt', header=F)`   
X_test.txt has all test dataset (2947 rows)   
`data_test <- read.table('UCI HAR Dataset/test/X_test.txt', header=F, row.names=NULL)`   
y_test.txt has all activity ids (2947 rows)   
`label_test <- read.table('UCI HAR Dataset/test/y_test.txt', header=F)`   
X_train.txt has all train dataset (7352 rows)   
`data_train <- read.table('UCI HAR Dataset/train/X_train.txt', header=F, row.names=NULL)`  
y_train.txt has all activity ids (7352 rows)   
`label_train <- read.table('UCI HAR Dataset/train/y_train.txt', header=F)`  
subject_train.txt has subject id for train dataset (7352 rows)   
`subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', header=F)`  
subject_test.txt has subject id for test dataset (2947 rows)   
`subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt', header=F)`   
activity_labels.txt has all 6 descriptions for each activity id   
`activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt', header=F)`  

After, we have to join all test datasets and puts the correct column names. Then we need to do the same with train datasets. After of this, we join train and test dataset getting a unique dataset with 563 columns and 10299 rows.

Using regular expressions, we get in a new dataset (tidyData) only mean, std, activity and subject columns as requested.  
`toMatch <- c(".*mean\\(\\)", ".*std\\(\\)", ".*subject",".*activity")  
matches <- unique (grep(paste(toMatch,collapse="|"), colnames(mergedData), value=TRUE))  
tidyData <- mergedData[,matches]`

Now, we assign labels for activity factors.

`tidyData$activity <- factor(tidyData$activity, levels=activity_labels$V1, labels=activity_labels$V2)` 

At the last, we converted the tidyData in a data.table and reshape as requested.

`tidyData <- as.data.table(tidyData)  
tidyData <- tidyData[, lapply(.SD, mean), by=c("activity","subject"), .SDcols=1:66]`

We write the dataset in tidyData.txt in workspace.   
`write.table(tidyData, "tidyData.txt")`
