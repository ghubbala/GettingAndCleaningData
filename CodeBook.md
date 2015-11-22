Introduction

The script run_analysis.R performs the steps specified in the project.

First, all the similar data is merged using the rbind() function. 
The mean and standard deviation measures are extracted and named using names from features.txt.
Activity data is addressed with values 1:6, he activitty names and IDs from activity_labels.txt are substituted in the dataset.
New dataset with all the average measures for each subject and activity type (30 subjects * 6 activities = 180 rows) are generated as  averages_data.txt.

Variables

The data from the downloaded files are x_train, y_train, x_test, y_test, subject_train and subject_test
x_, y_ and subject_ are merged the previous datasets to further analysis.
features contains the correct names for the x_data dataset, which are applied to the column names stored in mean_and_std_features, a numeric vector used to extract the desired data.
Similarly activity names are extracted through the activities variable.
all_data merges x_data, y_data and subject_data into a dataset.
ddply() is used to apply colMeans().
Average data is stored in a averages_data.txt file

