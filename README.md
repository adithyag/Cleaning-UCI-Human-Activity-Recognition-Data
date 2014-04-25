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
Run the __run_analysis.R__ script in R shell enviroment such as RStudio to create the tidy data that is specified in the project requirements. You can use __get_original_data.R__ script to download and unzip the dataset from UCI.

###Preprocessing
We do some preprocessing to merge all the files into one single table without losing any information in the process.
* The script first reads the features.txt and activity_labels.txt into ___flabels___ and ___alabels___ tables for naming purposes.
* The script reads X_test.txt and X_train.txt into two tables ___test___ and ___train___ respectively.
* The script applies each row of ___flabels___ as the column name for corresponding column of both the ___test___ and the ___train___ tables.
* The script reads Y_test and Y_train into tables atest and atrain respectively. The prefix __'a'__ stands for activity. The only column of these tables is names ___Activity_Code___.
* To ___atest___ and ___atrain___ tables, the script adds a column that makes the activity information more understandable called ___Activity_Name___. The data it contains is the activity label in ___alabel___ that corresponds to the activity code in the the ___atest___ and the ___atrain___ tables.
* The script reads subject_test.txt and subject_train.txt into ___stest___ and ___strain___ tables respectively with column label ___Subject_Id___.
* Although, its not required for this assignment, for thoroughness, the script creates a vector called ___Data_set___ consisting of values __"test"__ repeated as many times as there are rows in the ___test___ table. The script then combine ___stest___, ___atest___, ___Data_Set___ and test into one single table called ___full_test___. The script, now recreates ___Data_Set___ vector with values __"train"__ repeated as many times are there are rows in the ___train___ table. The script then combines ___strain___, ___atrain___, ___Data_set___ and ___train___ into one table called ___full_train___. The ___Data_Set___ column marks all the rows with the data subset they originally belong to. This may be useful for future modifications.
* The script combines the ___full_test___ and ___full_train___ tables into a one big table called ___alldata___ that has rows from both the tables. This should merge easily as they both have same column names.

###Creating Tidy Data
We use the ___alldata___ table to create the tidy data we need.
* The project requires means of all variables that are themselves means or standard deviations. So, the script gets the list of all column indices whose headings contain the words __"mean"__ or __"std"__.
* The script creates a table called ___usefuldata___ that only contains ___Subject_Id___, ___Activity_Name___ and all columns that contain __"mean"__ and __"std"__ values obtained in above step. This basically selects the columns we need from the ___alldata___ table for final deliverable.
* The script aggregates all the columns using ___mean___ function grouped by ___Activity_Name___ followed by ___Subject_Id___ and saves it into ___tidyData___ table.
* The script finaly writes the table into a text file called ___TidyData.txt___ along with the header but without the row names.

## Code Book for TidyData.txt
* ___Column 1 - Subject_Id___ : This contains the subject Id number ranging form 1 to 30. This numbering is retained from the original data set from UCI.
* ___Column 2 - Activity_Name___ : This is the activity being performed while the measuresments for the row were being taken. These names are from the activity_labels.txt in original data set. These names are self-explanatory.
* ___Columns 3 to 88___: Columns match the names used in the features.txt file from the original data set. More infromation is available in ___features_info.txt___ file in the original data set. Each value is the average of all the values for that column for the same combination of subject (Subject_Id) and activity (Activity_Name).
