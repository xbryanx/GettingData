#setwd('C:/Users/victor osorio/Documents/Bryan/DataScience/GettingData/PeerReview')

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

features <- read.table('UCI HAR Dataset/features.txt', header=F)
data_test <- read.table('UCI HAR Dataset/test/X_test.txt', header=F, row.names=NULL)
label_test <- read.table('UCI HAR Dataset/test/y_test.txt', header=F)
data_train <- read.table('UCI HAR Dataset/train/X_train.txt', header=F, row.names=NULL)
label_train <- read.table('UCI HAR Dataset/train/y_train.txt', header=F)
subject_train <- read.table('UCI HAR Dataset/train/subject_train.txt', header=F)
subject_test <- read.table('UCI HAR Dataset/test/subject_test.txt', header=F)
activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt', header=F)
colnames(data_train) <- features$V2
colnames(data_test) <- features$V2
colnames(label_train) <- c("activity")
colnames(label_test) <- c("activity")
colnames(subject_train) <- c("subject")
colnames(subject_test) <- c("subject")

data_train <- cbind(data_train, label_train, subject_train)
data_test <- cbind(data_test, label_test, subject_test)

mergedData <- rbind(data_train,data_test)
toMatch <- c(".*mean\\(\\)", ".*std\\(\\)", ".*subject",".*activity")
matches <- unique (grep(paste(toMatch,collapse="|"), colnames(mergedData), value=TRUE))
tidyData <- mergedData[,matches]
tidyData$activity <- factor(tidyData$activity, levels=activity_labels$V1, labels=activity_labels$V2)
library(reshape2)
library(data.table)
tidyData <- as.data.table(tidyData)
tidyData <- tidyData[, lapply(.SD, mean), by=c("activity","subject"), .SDcols=1:66]
write.table(tidyData, "tidyData.txt")
