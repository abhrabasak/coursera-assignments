# README for Course Project - Getting and Cleaning Data (July 2015)
ABHRA  
Sunday, July 19, 2015  
The following document is the description for the working of the R script in this project, and describes how the data has been cleaned up, transformed, analysed and summarised.

First things first - the packages - `data.table` for `fread` and `dplyr` required for data loading and cleanup - have been loaded.


```r
library(data.table)
library(dplyr)
```

Following the loading of packages, the provided datasets are loaded from the **train** and **test** folders. Train and Test data are read in separately as they are stored in independent files. Reading files containing feature values is straightforward - as it is already in a whitespace-separated  table format.
`read.table` works perfectly for such a dataset. However, reading in **Label** and **Subject** values requires use of `fread` as they are not in a table format.


```r
# Read In
x_train <- read.table("train/X_train.txt", quote="\"")
y_train <- fread("train/y_train.txt")
subject_train <- fread("train/subject_train.txt")

x_test <- read.table("test/X_test.txt", quote="\"")
y_test <- fread("test/y_test.txt")
subject_test <- fread("test/subject_test.txt")
```

Next the Activity Labels and the Feature names have been read in. Activity Labels describe the detected actions, corresponding to the measurements of features in the dataset. Feature names are the labels for the columns in the `X` dataset that are going to be used as headings in the table.


```r
activity_labels <- read.table("activity_labels.txt", quote="\"")
features <- read.table("features.txt", quote="\"", stringsAsFactors = FALSE)
```

The Subject, Features and Label data respectively have been arranged in adjacent columns. This is repeated once each for **train** and **test**.


```r
# Full dataset
train <- cbind.data.frame(subject_train, x_train, y_train)
test <- cbind.data.frame(subject_test, x_test, y_test)
```

Subsequently, the train and test datasets have been merged to form the final tabular dataset `merged`.


```r
# Merge and Naming
merged <- rbind.data.frame(train, test)
```

Column names have been added to the table using information available in the `features` data, and the activity serial numbers have been replaced with descriptive names of Activities. Sine the subjects in the study are discrete values, corresponding to volunteering individuals, it has been treated as a `factor`.


```r
colnames(merged) <- c("subject", features$V2, "label")
merged$subject <- as.factor(merged$subject)
# Name the activity labels (make it descriptive)
merged$label <- activity_labels$V2[merged$label]
```

Creating a final table data frame `mergedt` containing the entire informationready for analysis, cleanup and transformation. This has been done using the `tbl_df` function of `dplyr`.


```r
mergedt <- tbl_df(merged)
```

Only those columns which contain mean() or std() in their names have been selected. Using the `filter` function achieves this.


```r
# Filtered dataset with only mean and std columns (keep the label and subject)
selected_features <- features %>% filter(grepl("mean\\(\\)|std\\(\\)", V2)) %>% select(V2)
```

The corresponding feature names have been plucked out in `selected_features` and used to select only those columns corresponding to those features.


```r
selected_features <- c("subject", as.character(selected_features$V2), "label")
selected_data <- mergedt[, selected_features]
```

Finally summarising the means of all columns grouped by label and subject. The `summarise_each` acts on each of the groups and applies the `mean` function on each.


```r
# Summarising data - mean grouped by label and subject
summarised_data <- selected_data %>% group_by(label, subject) %>% summarise_each(funs(mean))
```

The final summarised data has then been written out with the column names as headings. The file `selected_data.tsv` is a tabular formatted file which contains tab-sparated data, and can be readily loaded using `read.table`.


```r
# Persist the data for upload
write.table(selected_data, "selected_data.txt", row.names = FALSE, col.names = TRUE)
```

-END-
