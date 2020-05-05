# GettingCleaningDataProgAss
The repository for the final programming assignment for Coursera course 'Getting and Cleaning Data'

This readme contains explanations of the code.

The script _run_analysis_ transforms the raw data of the UCI HAR dataset into two datasets:
- UCIHAR_tidy: A tidy dataset, a merge of the original training and testing set
- UCIHAR_average: Another tidy dataset, containing the average of each of the variables in the previous data set for each subject and activity

The script performs six steps to achieve this result, which will now be explained in more detail.
1. The training and testing set (both the X and Y) are merged, into _new_X_ and _new_Y_ respectively
2. The measurements containing _mean_ or _std_ are selected; the others are filtered out
3. The descriptive activity names are retrieved from _activity_labels.txt_ and replace the un-informative digits to denote activities
4. The labels for every variable are retrieved from _features.txt_ and set as variable names. Furthermore, a space is added before every capitalized letter (for readability) and underscores are replaced by spaces (also for readability)
5. A new data set is created, taking the mean of every variable in the data set of step 4 for every subject and every activity. The resulting dataset is a table containing the number of variables x (the number of subjects * the number of activities) values.
6. The resulting two data sets (from step 4 and step 5) are then written to csv.
