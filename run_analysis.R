# Merge the training and the test sets to create one data set.
train_x <- read.table(".UCI_HAR_Dataset/train/X_train.txt")
train_y <- read.table(".UCI_HAR_Dataset/train/Y_train.txt")
test_x <- read.table(".UCI_HAR_Dataset/test/X_test.txt")
test_y <- read.table(".UCI_HAR_Dataset/test/Y_test.txt")

merged_x <- rbind(train_x,test_x)
merged_y <- rbind(train_y,test_y)

names(merged_x) <- read.table(".UCI_HAR_Dataset/features.txt")["V2"][[1]]
names(merged_y) <- c("activity_label")

remove(train_x)
remove(train_y)
remove(test_y)
remove(test_x)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_and_std_mt <- merged_x[grep("mean|std",names(merged_x))]

# Uses descriptive activity names to name the activities in the data set.
acitivty_table <- read.table(".UCI_HAR_Dataset/activity_labels.txt")
activity_dict <- as.character(acitivty_table["V2"][[1]])
activity_label <-c()

for(label_index in 1:length(merged_y[,1])) {
    activity_label[label_index] <- as.character(activity_dict[merged_y[label_index,1]])
}
desc_y <- data.frame(activity_label)

remove(activity_label)
remove(acitivty_table)
remove(activity_dict)

# Appropriately labels the data set with descriptive variable names. 
merged_xy <- cbind(mean_and_std_mt,desc_y)

remove(merged_y)
remove(merged_x)
remove(mean_and_std_mt)
remove(desc_y)

# Create independent tidy data set with the average of each variable for each activity and each subject.
subject_train <- read.table(".UCI_HAR_Dataset/train/subject_train.txt")
subject_test <- read.table(".UCI_HAR_Dataset/test/subject_test.txt")
merged_subject <- rbind(subject_train,subject_test)
names(merged_subject) <- "subject"
merged_all <- cbind(merged_xy,merged_subject)

tidy <- summarise_each(group_by(merged_all,activity_label,subject),funs(mean))
colnames(tidy) <- c("subject","activity",paste("mean_of", colnames(merged_all)[1:(length(merged_all)-2)], sep = "_"))
write.table(tidy,"tidy.txt",row.names = F)

remove(subject_train)
remove(subject_test)
remove(merged_subject)
remove(merged_xy)
remove(merged_all)
remove(tidy)