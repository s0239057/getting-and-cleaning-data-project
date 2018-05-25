Getting and Cleaning Data: Course Project
=========================================
INTRO
------------
This codebook explains the data structure and modifications made to the data to create a tidy dataset and the resulting output.
This repository contains work for the "Getting and Cleaning data" course, which is part of the Data Science Specialization series by Johns Hopkins.

ORIGINAL DATASET 
(see README.md for more information on the dataset).70% training set, 30% testing set
------------------
features.txt: [561 x 2] table containing the feature names of the derived feature variables
activity_labels.txt: [6 x 2] table containing activity id and labels
------------------
Training Data

X_train.txt: [7352 x 561] table containg the measured and derived feature variables for each subject and activity [TRAINING DATA]
Y_train.txt: [7352 x 1] table containing the activity codes [TRAINING DATA]
Subject_train.txt: [7352 x 1] table containing the subject codes [TRAINING DATA]

Test Data

X_test.txt: [2947 x 561] table containg the measured and derived feature variables for each subject and activity [TEST DATA]
Y_test.txt: [2947 x 1] vector containing the activity codes [TEST DATA]
Subject_test.txt: [2947 x 1] vector containing the subject codes [TEST DATA]

SCRIPTING
-------------------------------------
run_analysis.R script has been produced that does the following:

(1) Merges the individual feature, activity and subject training and test datasets
(2) Retains the features related to mean and standard deviation calculations
(3) Merges all the data into a single table and modifies the variable (column) names
(4) Calculates the mean feature values grouped by subject and activity
(5) Writes the result from (4) to a tab delimited file tidy_data.txt

The data in file "UCI HAR Dataset" must be downloaded and extracted before the analysis is performed.