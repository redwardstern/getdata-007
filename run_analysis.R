#features & labels
setwd("~/coursera/getdata-007/uci_har_dataset/")
features <- read.table("features.txt")
cols <- features[grep("-mean\\(|-std\\(|Mean|meanFreq\\(", features[,2]),]
col.names <- as.character(cols[,2])
col.index <- as.numeric(cols[,1])
activity_labels <- read.table("activity_labels.txt")

#test set
setwd("~/coursera/getdata-007/uci_har_dataset/test/")
X_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
#y_test$activity <- as.character(activity_labels[match(c(y_test[,1]), c(activity_labels[,1])) ,2])
subject_test <- read.table("subject_test.txt")
X.test <- X_test[,col.index]
colnames(X.test) <- col.names
X.test$activity <- as.character(activity_labels[match(c(y_test[,1]), c(activity_labels[,1])) ,2])
X.test$subject <- as.numeric(subject_test[, 1])

#train set
setwd("~/coursera/getdata-007/uci_har_dataset/train/")
X_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")
#y_train$activity <- as.character(activity_labels[match(c(y_train[,1]), c(activity_labels[,1])) ,2])
subject_train <- read.table("subject_train.txt")
X.train <- X_train[,col.index]
colnames(X.train) <- col.names
X.train$activity <- as.character(activity_labels[match(c(y_train[,1]), c(activity_labels[,1])) ,2])
X.train$subject <- as.numeric(subject_train[, 1])

#merge sets
X<-rbind(X.test, X.train)

#average, tidy, write-to-file
setwd("~/coursera/getdata-007/")
finx <- dim(X)[2]-2
X.tidy <- aggregate(as.matrix(X[ ,1:finx]) ~ activity + subject, data=X, FUN=mean)
write.csv(X.tidy, "tidy.csv", row.names=FALSE)