# Getting and Cleaning Data - Course Project for Data Science specialisation

The run_analysis.R script was developed to do the following:

1. Creates a directory, download and unzips the data files
2. Loads both training and test datasets and retains those variables related to mean and standard deviation calculations
3. Loads the activity and subject datasets and merges these with the respective training and test feature sets
4. Merges both training and testing datasets to create a single dataset
5. Tidies up and assigns meaningful variable (column) names to the dataset
6. Groups the dataset by subject and activity and calculates the mean and standard deviation of each variable for each subject and activity

The result is made available in the file `tidy_data.txt`.