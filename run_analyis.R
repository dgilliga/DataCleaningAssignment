

## get the training data!!
x_training_data <- read.table("dataset/UCI HAR Dataset//train/X_train.txt",sep="", header=FALSE)
## get test data
x_test_data <- read.table("dataset/UCI HAR Dataset/test/X_test.txt",header=FALSE)

## combine data sets
combined_data <- rbind(x_training_data,x_test_data)

## get feature types file to get column names
feature_types <- read.table("dataset/UCI HAR Dataset/features.txt")

## add names to the columns of the combined data
colnames(combined_data)= feature_types$V2

#get file with activity types mapped to descriptions
activity_type_map<- read.table("dataset/UCI HAR Dataset/activity_labels.txt")

#get training activity type data
training_activity_type <- read.table("dataset/UCI HAR Dataset/train//y_train.txt", sep="", header=FALSE)

#get test activity type data
test_activity_type <- read.table("dataset/UCI HAR Dataset/test/y_test.txt", header=FALSE)

#combine training and test activity type data
combined.activity.data <- rbind(training_activity_type,test_activity_type)

### extract mean and standard deviation data
mean_std_data <- combined_data[,grep("mean|std",names(combined_data))]

### add activity type column to the extracted mean and std data
mean_std_data <- cbind(mean_std_data,activity_type = activity_type_map[combined.activity.data$V1,"V2"])

### get subject data for training 
training.subject.data <- read.table("dataset/UCI HAR Dataset/train/subject_train.txt", header=FALSE)

### get subject data for test
test.subject.data <- read.table("dataset/UCI HAR Dataset/test/subject_test.txt", header=FALSE)

### combined subject data
combined.subject.data <- rbind(training.subject.data,test.subject.data)

### add subject data to our data frame
mean_std_data <- cbind(mean_std_data,subject_id = combined.subject.data$V1)

names(mean_std_data) <- gsub("[-]",".",names(mean_std_data))

names(mean_std_data) <- gsub("[(][)]","",names(mean_std_data))

names(mean_std_data) <- gsub("tBody","Time.Domain.Body",names(mean_std_data))
names(mean_std_data) <- gsub("fBody","Freq.Domain.Body",names(mean_std_data))

names(mean_std_data) <- gsub("tGravity","Time.Domain.Gravity",names(mean_std_data))


mean.overall.by.activity.and.subject <- aggregate(.~activity_type+subject_id,data=mean_std_data,mean)

write.table(mean.overall.by.activity.and.subject, "overall_mean_by_activity_and_subject" )