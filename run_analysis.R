## Step 0 => Unzip all files to the Working Directory.
## Read the tables

xtrain <- read.table("X_train.txt")
xtest <- read.table("X_test.txt")

## 1. Merges the training and the test sets to create one data set.

xtotal <- rbind(xtrain,xtest)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

## reads the names of the features
feat <- read.table("features.txt")
## adds the names of the features to the data
names(xtotal) <- feat$V2
## select the columns with mean or std in the name
mean_std <- feat$V2[grep("mean\\(\\)|std\\(\\)",feat$V2)]
## creates sub table with only those columns
seleccion <- subset(xtotal,select=mean_std)


## 3. Uses descriptive activity names to name the activities in the data set

## reads the activities names
ytrain <- read.table("y_train.txt")
ytest <- read.table("y_test.txt")
actlab <- read.table("activity_labels.txt")
## joins the activities names
ytotal <- rbind(ytrain,ytest)
## adds the activities names
ytotal <- merge(ytotal,actlab)
names(ytotal) <- c("V1","activity")
xtotal <- cbind(xtotal,ytotal)

## 4. Appropriately labels the data set with descriptive variable names.

## Replace time instead of t
names(xtotal) <- gsub("^t","time",names(xtotal))
## Replace frequency instead of f
names(xtotal) <- gsub("^f","frequency",names(xtotal))
## Replace Magnitude instead of Mag
names(xtotal) <- gsub("Mag","Magnitude",names(xtotal))
## Replace Accelerometer instead of Acc
names(xtotal) <- gsub("Acc","Accelerometer",names(xtotal))
## Replace Gyroscope instead of Gyro
names(xtotal) <- gsub("Gyro","Gyroscope",names(xtotal))
## Replace Body instead of BodyBody
names(xtotal) <- gsub("BodyBody","Body",names(xtotal))


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Add the subject info
sub_train <- read.table("subject_train.txt")
sub_test <- read.table("subject_test.txt")
sub_total <- rbind(sub_train,sub_test)
names(sub_total) <- c("Subject")
xtotal <- cbind(xtotal,sub_total)

## Calculates mean and sort the data
xtotal2 <- aggregate(. ~Subject + activity, xtotal, mean)
xtotal2 <- select(xtotal2,-V1)
xtotal2 <- arrange(xtotal2,Subject,activity)

