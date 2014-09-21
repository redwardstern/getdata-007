#features & labels
setwd("getdata-007/uci_har_dataset/")
features <- read.table("features.txt")
cols <- features[grep("-mean\\(|-std\\(|Mean|meanFreq\\(", features[,2]),]
col.names <- as.character(cols[,2])
col.index <- as.numeric(cols[,1])
activity_labels <- read.table("activity_labels.txt")

#test set

X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
X.test <- X_test[,col.index]
colnames(X.test) <- col.names
X.test$activity <- as.character(activity_labels[match(c(y_test[,1]), c(activity_labels[,1])) ,2])
X.test$subject <- as.numeric(subject_test[, 1])

#train set
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
X.train <- X_train[,col.index]
colnames(X.train) <- col.names
X.train$activity <- as.character(activity_labels[match(c(y_train[,1]), c(activity_labels[,1])) ,2])
X.train$subject <- as.numeric(subject_train[, 1])

#merge sets
X<-rbind(X.test, X.train)

#average, tidy, write-to-file
finx <- dim(X)[2]-2
X.tidy <- aggregate(as.matrix(X[ ,1:finx]) ~ activity + subject, data=X, FUN=mean)
write.csv(X.tidy, "../../tidy.csv", row.names=FALSE)