==================================================================
Getting and Cleaning Data course project dataset
Version 1.0
==================================================================
Cfir Rahimi
==================================================================

the dataset contain information extracted from Samsung dataset given in the assignment.
the dataset reflect the average value for every feature in the samsung data according to the subject, which did the experment, and the activity that was labled in the experment.

The dataset includes the following files:
=========================================

- 'README.md'

- 'tidy.txt': the tidy table extraceted for the assignment.

- 'run_analysis': the script that creaing tidy.txt.

- 'dataset': assignment dataset.

- 'codebook.docx': codebook for the tidy.txt table.

script flow: 
============

1. Merge the training and the test sets to create one data set.
	- using read.table to read the files.
	- using rbind() to merge them.
	- insert to the names vector of the merged data the names from feature.txt file.
	- remove unrelevent objects.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 
	- using grep() on the names of the merged data to create the subset required.

3. Uses descriptive activity names to name the activities in the data set.
	- read the file activity_lables.txt for creating activity dictionary between activity number and name.
	- replace the data in the activity_label variable according to the dictionary.
	- remove unrelevent objects.

4. Appropriately labels the data set with descriptive variable names.
	- merging the lables with the data.

5. Create independent tidy data set with the average of each variable for each activity and each subject.
	- read subject data, merge train and test.
	- using cbind to merged it into the data. 
	- using group by and summarise_each to create the tidy data.
	- change the names of the tidy data.
	- write it into tidy.txt using write.table().
	- remove unrelevent objects.
