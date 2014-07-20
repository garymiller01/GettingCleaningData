
A brief run-through of my run_analysis.R script.


1)  Download a zip file containing the required files, and unzip into the specified directory.

2)  For reproducibility, store the date the files were downloaded as a variable.

3)  Read in Features.txt, which contains the names of every feature in the X_train and X_test files.  They will be used as column names for the merged dataset.

4)  Read in:

* subject_train.txt, which contains the number assigned to the participant for each observation / row in x_train and x_test.

* X_train.txt, which contains the actual values

* y_train.txt, which contains the activities being performed during each observation.

Repeat for the test datasets.

5)  Assign column names to each individual file.   

6) Create vectors consisting of the names of variables where the mean and standard deviation of the measurement are recorded.  Use them to subset the x_train and x_test files, and overwrite with only the required columns.

7) Combine the subject, activity, and values into one single dataframe for each of the datasets:  train and test.  Then, combine the test and train datasets into one merged dataframe.

8) Read in activity_labels.txt, which contains text descriptions of each activity type and corresponding numeric codes.

9) Replace activity codes with the text decriptions in the merged dataframe.

10) Melt the merged dataframe.

11) Cast a new, tidy dataset, calculating the mean of each variable as broken out by both subject and activity.

12) Rename columns to indicate the values are now means, and to make more readable.

13) Write final tidy dataset to .txt file.

14) Write files useful for creating codebook to .txt files.
