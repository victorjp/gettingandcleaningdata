# gettingandcleaningdata
This repository contains the run_analysis.R script and codebook for the summarized data set
that outputs this script, also called SummaryDT in the code.

The code in general loads all the required data sets, assuming the original data set
is in the working directory under the folder UCI HAR Dataset.
Then combines the training and test correspondant parts.
Finally it subsets the means and standard deviation variables and merges everything together.

It then takes the mean of all the variables per each subject and activity in a data table called SummaryDT.

There is definitively some opportunities to make the code run faster, but I'm happy
with the overall performance of this first script.

To run the code you need to source the run_analysis.R script using
source("run_analysis.R") assuming the file is located in your working directory.

