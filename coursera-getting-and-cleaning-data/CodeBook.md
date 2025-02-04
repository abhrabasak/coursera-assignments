# Code Book
ABHRA  
Saturday, July 25, 2015  
The dataset is based on the **Human Activity Recognition Using Smartphones Dataset** (Version 1.0) by *Jorge L. Reyes-Ortiz*, *Davide Anguita*, *Alessandro Ghio*, *Luca Oneto* of [Smartlab - Non Linear Complex Systems Laboratory](www.smartlab.ws) in Genoa, Italy. The dataset consists of 10299 observations of 68 variables (features/columns) that are derived by analysis and transformations on the above dataset.

The first column `subject` is the identifier of the volunteering individual corresponding to the observation. The last column `label` is the detected activity determined from the observed values, and can take the following values - *WALKING*, *WALKING_UPSTAIRS*, *WALKING_DOWNSTAIRS*, *SITTING*, *STANDING*, *LAYING*.
The remaining 66 variables are of the form `[t|f]<measure>-<stat>-{XYZ}` where `t` and `f` denotes tme and frequency domain measures respectively.

The features in this dataset come from the accelerometer and gyroscope 3-axial raw signals `tAcc-XYZ` and `tGyro-XYZ` respectively. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise, and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window).

Similarly, the acceleration signal was then separated into body and gravity acceleration signals (`tBodyAcc-XYZ` and `tGravityAcc-XYZ`) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

The body linear acceleration and angular velocity were derived in time to obtain Jerk signals (`tBodyAccJerk-XYZ` and `tBodyGyroJerk-XYZ`). The magnitudes of these three-dimensional signals were calculated using the Euclidean norm (`tBodyAccMag`, `tGravityAccMag`, `tBodyAccJerkMag`, `tBodyGyroMag`, `tBodyGyroJerkMag`).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing `fBodyAcc-XYZ`, `fBodyAccJerk-XYZ`, `fBodyGyro-XYZ`, `fBodyAccJerkMag`, `fBodyGyroMag`, `fBodyGyroJerkMag`. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern (`-XYZ` is used to denote 3-axial signals in the `X`, `Y` and `Z` directions).

- `tBodyAcc-XYZ`
- `tGravityAcc-XYZ`
- `tBodyAccJerk-XYZ`
- `tBodyGyro-XYZ`
- `tBodyGyroJerk-XYZ`
- `tBodyAccMag`
- `tGravityAccMag`
- `tBodyAccJerkMag`
- `tBodyGyroMag`
- `tBodyGyroJerkMag`
- `fBodyAcc-XYZ`
- `fBodyAccJerk-XYZ`
- `fBodyGyro-XYZ`
- `fBodyAccMag`
- `fBodyAccJerkMag`
- `fBodyGyroMag`
- `fBodyGyroJerkMag`

The set of statistical summary measures that were estimated from these signals are:

- `mean()`: Mean value
- `std()`: Standard deviation

All other statistical summary measures were filtered out.
