#Readme
##Introduction
This work is done for the project in the course "Getting and Cleaning Data" at https://class.coursera.org/getdata-002. The goal of the assignment is to create a tidy data set that contains averages of all variables that are some kind of a mean or std (standard deviation) for each combination of subject and activity from the raw data provided by UCI for activity tracking using wearable devices.

##Source of the raw data
Original data is obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The information is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. Please read the Readme file in the zip for how this data was collected and processed by UCI.

## The files used by this project
The zip file unzips into "HAR UCI Dataset" folder. We use the following files.
* "HAR UCI Dataset/features.txt"
* "HAR UCI Dataset/activity_labels.txt"
* "HAR UCI Dataset/test/X_test.txt"
* "HAR UCI Dataset/test/y_test.txt"
* "HAR UCI Dataset/test/subject_test.txt"
* "HAR UCI Dataset/train/X_train.txt"
* "HAR UCI Dataset/train/y_train.txt"
* "HAR UCI Dataset/train/subject_train.txt"

Script ignores the raw data in subfolders of test and train as this already processed into X_train and X_test by people with domain knowledge. For thorough verification, one must verify their logic and the correctness of the processed data. This verification is out of the scope of this project.

## The Processing Script
Run the run_analysis.R script in R shell enviroment such as RStudio to create the tidy data that is specified in the project requirements. You can use get_original_data.R script to download and unzip the dataset from UCI.

###Preprocessing
We do some preprocessing to merge all the files into one single table without losing any information in the process.
* The script first reads the features.txt and activity_labels.txt into 'flabels' and 'alabels' tables for naming purposes.
* The script reads X_test.txt and X_train.txt into two tables test and train respectively.
* The script applies each row of flabels as the column name for corresponding column of both test and train tables.
* The script reads Y_test and Y_train into tables atest and atrain respectively. The prefix 'a' stands for activity. The only column of these tables is names Activity_Code.
* To atest and atrain, the script adds a column that makes the activity information more understandable called Activity_Name. The data it contains is the activity label in alabel that corresponds to the activity code in atest and atrain.
* The script reads subject_test and subject_train into stest and strain tables respectively with column label "Subject_Id"
* Although, its not required for this assignment, for thoroughness, the script creates a vector called "Data_set" consisting of values "test" repeated as many times as there are rows in the test table. The script then combine stest, atest, Data_Set and test into one single table called full_test. The script, now recreates Data_Set vector with values "train" repeated as many times are there are rows in the train table. The script then combines strain, atrain, Data_set and train into one table called full_train. The Data_Set column marks all the rows with which sub data set they belong to. This may be useful for future modifications.
* The script combines the full_test and full_train tables into a one big table called alldata that has rows from both the tables. This should merge easily as they both have same column names.

###Creating Tidy Data
We use the alldata table to create the tidy data we need.
* The project requires means of all variables that are themselves means or standard deviations. So, the script gets the list of all column indices whose headings contain the words "mean" or "std".
* The script creates a table called usefuldata that only contains Subject_Id, Activity_Name and all columns that contain "mean" and "std" values obtained in above step. This basically selects the columns we need from the alldata table.
* The script aggregates all the columns using mean function grouped by activity followed by subject and saves it into tidyData table.
* The script finaly writes the table into a text file called TidyData.txt along with the header but without the row names.

## Code Book for TidyData.txt
* Column 1 - Subject_Id : This contains the subject Id number ranging form 1 to 30. This numbering is retained from the original data set from UCI.
* Column 2 - Activity_Name : This is the activity being performed while the measuresments for the row were being taken. These names are from the activity_labels.txt in original data set. These names are self-explanatory.
* Columns 3 to 88: Columns match the names used in the features.txt file from the original data set. More infromation is available in features_info.txt file in the original data set. Each value is the average of all the values for that column for the same combination of subject (Subject_Id) and activity (Activity_Name).
