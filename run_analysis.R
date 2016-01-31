
#Run Analysis script
#Create by victor jaen

#This script is for the project of the getting and cleaning data course
#The data set folder of Human Activity Recognition Using Smartphones dataset needs to be on the working directory
#The output is a summarized dataset with the average per subject & activity
#of all the means and standard deviations variables

#Is also required to have the data.table package installed

#loads the data.table package
library(data.table)

#All the datasets are loaded

features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
test_X <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
test_Y <- read.table("UCI HAR Dataset/test/y_test.txt",header = FALSE)
test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt",header = FALSE)
train_X <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
train_Y <- read.table("UCI HAR Dataset/train/y_train.txt",header = FALSE)
train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt",header = FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",header = FALSE)


#We combine first the test and train data sets

X_combined <- rbind(test_X,train_X)
Y_combined <- rbind(test_Y,train_Y)

#Then we replace the activity numbers with activity names, the variable becomes a factor
Y_combined_wlabels <- merge(Y_combined,activity_labels)
Y_combined_wlabels[,1] <- NULL 
subject_combined <- rbind(test_subject,train_subject)


#now we get the names and positions of all the variables having mean and std (standard deviations)
#in the name.
means_positions <- features[grepl("mean()",features[,2], fixed = TRUE),1]
means_names <- as.character(features[grepl("mean()",features[,2], fixed = TRUE),2])
std_positions <- features[grepl("std",features[,2], fixed = TRUE),1]
std_names <- as.character(features[grepl("std",features[,2], fixed = TRUE),2])                           



#we subset the positions of both means and std and combine them
X_combined_means <- X_combined[,means_positions]
X_combined_std <- X_combined[,std_positions]
X_combined_means_std<-cbind(X_combined_means,X_combined_std)

#the datasets are combined to its final not summarized version

combined_tidy <- cbind(subject_combined,Y_combined,X_combined_means_std)
#adds names to the combined data set
names(combined_tidy)<-c("Subjects","Activity",means_names,std_names)

#Converts the tidy dataset to data table and then
#summarizes it by the subject and activity variables
combined_tidyDT <- data.table(combined_tidy)
SummaryDT<- combined_tidyDT[,lapply(.SD,mean), by=c("Subjects","Activity")]
#Orders the summary data set
SummaryDT <- SummaryDT[order(Subjects,Activity)]l
#Writes the summarized data table as a txt file
write.table(SummaryDT,"summary_output.txt",row.names = FALSE)

#It finally removes all used datasets
rm(list = ls())


