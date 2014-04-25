##Read feature and activity labels
flabels <- read.table(file = "UCI HAR Dataset/features.txt", header = FALSE)
alabels <- read.table(file = "UCI HAR Dataset/activity_labels.txt", header = FALSE)

##Read and prepare test data
#read all records for test
test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE, row.names = NULL)

#set column names to feature labels
names(test) <- flabels[, 2]

#read activities of the test records
atest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)

#add a column that the describe the activity code and name the columns
atest <- alabels[atest[,],]
names(atest) <- c("Activity_Code", "Activity_Name")

#read subject ids the correspond to each record
stest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
names(stest) <- "Subject_Id"

#Create a vector that identifies that each record is from test data set
Data_Set <- rep("test", nrow(stest))

#Combine subjects table, activity table, data set vector and test records
#into one big table
full_test <- cbind(stest, atest, Data_Set, test)

##Repeat the above training data as well

##Read and prepare train data
#read all records for train
train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE, row.names = NULL)

#set column names to feature labels
names(train) <- flabels[, 2]

#read activities of the train records
atrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

#add a column that the describe the activity code and name the columns
atrain <- alabels[atrain[,],]
names(atrain) <- c("Activity_Code", "Activity_Name")

#read subject ids the correspond to each record
strain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
names(strain) <- "Subject_Id"

#Create a vector that identifies that each record is from train data set
Data_Set <- rep("train", nrow(strain))

#Combine subjects table, activity table, data set vector and train records
#into one big table
full_train <- cbind(strain, atrain, Data_Set, train)

##combine test and train records
alldata <- rbind(full_test, full_train)

#Get all column numbers which have mean and std values
meanstd_cols<-grep("std|mean",names(alldata), ignore.case=TRUE)

# Lets create a usefuldata that has subject, activity_name and mean/std columns
usefuldata <- alldata[, c(1,3,meanstd_cols)]

# Lets make the final tidy data
tidyData <- aggregate(.~Subject_Id+Activity_Name, usefuldata, mean)

# Write this a text file
write.table(tidyData,"TidyData.txt", row.names=FALSE)
