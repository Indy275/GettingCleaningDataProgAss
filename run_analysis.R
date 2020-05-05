# some imports
library(dplyr)
library(plyr)

# Reading in data from text files
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE)
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE)
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)

# 1. Merge the training and testing sets
new_X <- rbind(x=X_train, y=X_test)
new_Y <- rbind(x=Y_train, y=Y_test)

# 2. Select only the mean and standard deviations from each measurement
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE) 
new_X_mean_sd <- select(new_X, grep("mean()|std()", features$V2))

# 3. Label Y with descriptive activity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
activities <- sub("_", " ", activities[,2])

new_Y_names <- mutate(new_Y, V1 = recode(V1, "1" = tolower(activities[1]), 
                                             "2" = tolower(activities[2]),
                                             "3" = tolower(activities[3]),
                                             "4" = tolower(activities[4]),
                                             "5" = tolower(activities[5]),                           
                                             "6" = tolower(activities[6]),))

# 4. Label X with descriptive variable names
tidy_X <- cbind(new_X_mean_sd)
names(tidy_X) <- features[grep("mean()|std()", features$V2),][,2]
names(tidy_X) <- sub("Acc", "Acceleration", names(tidy_X)) 
names(tidy_X) <- gsub("*([A-Z])", " \\1", names(tidy_X))
names(tidy_X) <- gsub("-", " ", names(tidy_X))

# 5. Create second tidy data set containing average per activity per subject
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
new_subject <- rbind(x=subject_train, y=subject_test)

tidy_df <- mutate(tidy_X, subject = new_subject$V1)
tidy_df <- mutate(tidy_df, activity = new_Y_names$V1)

average_df <- tidy_df %>% group_by(subject, activity) %>% summarize_each(mean)

# 6. Output the two tidy data sets to text
write.table(tidy_df, "UCIHAR_tidy.txt", row.names = FALSE)
write.table(average_df, "UCIHAR_average.txt", row.names = FALSE)

names(average_df)
