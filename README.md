---
title: "Readme"
output: html_document
---

## Create Document
Merge both test and train files into a single dataset.  

### Features & Activities
Select features which contain mean(), std(), Mean, meanFreq()

```{r, echo=TRUE}
setwd("uci_har_dataset/")
features <- read.table("features.txt")
cols <- features[grep("-mean\\(|-std\\(|Mean|meanFreq\\(", features[,2]),]
col.names <- as.character(cols[,2])
col.index <- as.numeric(cols[,1])
activity_labels <- read.table("activity_labels.txt")
```

### Test
* Select the columns by features.
* Add activity column.
* Add subject column.

```{r, echo=TRUE}
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
#y_test$activity <- as.character(activity_labels[match(c(y_test[,1]), c(activity_labels[,1])) ,2])
subject_test <- read.table("test/subject_test.txt")

X.test <- X_test[,col.index]
colnames(X.test) <- col.names
X.test$activity <- as.character(activity_labels[match(c(y_test[,1]), c(activity_labels[,1])) ,2])
X.test$subject <- as.numeric(subject_test[, 1])
```

### Train
* Select the columns by features.
* Add Activity Label column.
* Add subject column. 

```{r, echo=TRUE}
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
#y_train$activity <- as.character(activity_labels[match(c(y_train[,1]), c(activity_labels[,1])) ,2])
subject_train <- read.table("subject_train.txt")

X.train <- X_train[,col.index]
colnames(X.train) <- col.names
X.train$activity <- as.character(activity_labels[match(c(y_train[,1]), c(activity_labels[,1])) ,2])
X.train$subject <- as.numeric(subject_train[, 1])
```

### Merge Sets
Combine the test and train datasets into a single frame.

```{r, echo=TRUE}
X<-rbind(X.test, X.train)
```

## Create Tidy Data Set
* Average each variable for each activity and each subject.
* Create tidy.csv file.

```{r, echo=TRUE}
finx <- dim(X)[2]-2
X.tidy <- aggregate(as.matrix(X[ ,1:finx]) ~ activity + subject, data=X, FUN=mean)
write.csv(X.tidy, "tidy.csv", row.names=FALSE)
```
