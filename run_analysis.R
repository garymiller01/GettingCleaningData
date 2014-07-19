
# Getting & Cleaning Data - Assignment 1

# download datasets

projectUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(projectUrl,destfile="./data/ProjectZip.zip")
unzip("./data/ProjectZip.zip",exdir="./data")

# Record date files were downloaded

dateDownloaded <- date()

# Read in Feature data

Features <- read.table("./data/UCI HAR Dataset/features.txt",header=FALSE,
                       stringsAsFactors=FALSE)

# Read in Train / Test Data

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",header=FALSE)
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt",header=FALSE)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt",header=FALSE)

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",header=FALSE)
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt",header=FALSE)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt",header=FALSE)

# assign column names

names(subject_train) <- "Subject.Number"
names(X_train) <- Features[,2]  # Feature names
names(y_train) <- "Activity"

names(subject_test) <- "Subject.Number"
names(X_test) <- Features[,2]  # Feature names
names(y_test) <- "Activity"

# Extract Mean, Std columns from x_train and x_test

meanCols <- grep("-mean()",Features[,2],fixed=TRUE,value=TRUE)
stdCols <- grep("-std()",Features[,2],fixed=TRUE,value=TRUE)

KeepCols <- c(meanCols,stdCols)

X_train <- X_train[,KeepCols]
X_test <- X_test[,KeepCols]

# Merge train and test data

TrainDF <- cbind(subject_train,y_train,X_train)
TestDF <- cbind(subject_test,y_test,X_test)

mergedDF <- rbind(TrainDF,TestDF)

# Read in Activity Numbers / Labels with Activity Names

ActivityLabels <- read.table("./Data/UCI HAR Dataset/activity_labels.txt",header=FALSE,
                             stringsAsFactors=FALSE)

# Replace #s with text activities

mergedDF$Activity <- as.factor(mergedDF$Activity)

library(plyr)

mergedDF$Activity <- mapvalues(mergedDF$Activity,from=ActivityLabels[,1],to=ActivityLabels[,2],warn_missing=TRUE)
  
# Create Second tidy dataset with means by subject & activity 

library(reshape2)

meltMergedDF <- melt(mergedDF,id=c("Subject.Number","Activity"))
tidyDF <- dcast(meltMergedDF,Subject.Number + Activity ~ variable,mean)

# rewrite column names for all but 1st two columns

names(tidyDF)[3:68] <- paste("Mean",names(tidyDF)[3:68])

# fix 'BodyBody' issue with variable

names(tidyDF) <- gsub("BodyBody","Body",names(tidyDF),fixed=TRUE)

# write tidy Dataset

write.table("./data/tidyDF.txt")
