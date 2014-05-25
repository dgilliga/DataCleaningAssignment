Creating Tidy data set with mean caculated per subject per activity
-------------------------

I started the analyis by using read.table to read in the training and test data.

I then combined them using rbind.

I then read the feature type file to find the activity names and then mapped the activity names to the numbers in the original data.


I also got the subject info

So now i had my data frame i decided to just do a simple grep for "mean" and "std"
to pull out the mean and standard deviation values from the original data.

I then used colbind to add the activivity data as a new column

I then used colbind to add the subject info data as a new col.

To tidy the column names i stuck with just removing underscores and "()". I just changed the strings at the start of the names to be "Time.Domainxxx" instead of "txxxxx". I did the same with "fxxxx" column names. Could have done more but think this was sufficient

Aggregate funciton was fine to calculate means for factors of activity type and subject

I then printed the new data to a file as a table



