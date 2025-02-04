library(data.table)
library(dplyr)

# Read In
x_train <- read.table("train/X_train.txt", quote="\"")
y_train <- fread("train/y_train.txt")
subject_train <- fread("train/subject_train.txt")

x_test <- read.table("test/X_test.txt", quote="\"")
y_test <- fread("test/y_test.txt")
subject_test <- fread("test/subject_test.txt")

activity_labels <- read.table("activity_labels.txt", quote="\"")
features <- read.table("features.txt", quote="\"", stringsAsFactors = FALSE)

# Full dataset
train <- cbind.data.frame(subject_train, x_train, y_train)
test <- cbind.data.frame(subject_test, x_test, y_test)
# Merge and Naming
merged <- rbind.data.frame(train, test)
colnames(merged) <- c("subject", features$V2, "label")
merged$subject <- as.factor(merged$subject)
# Name the activity labels (make it descriptive)
merged$label <- activity_labels$V2[merged$label]
mergedt <- tbl_df(merged)

# Filtered dataset with only mean and std columns (keep the label and subject)
selected_features <- features %>% filter(grepl("mean\\(\\)|std\\(\\)", V2)) %>% select(V2)
selected_features <- c("subject", as.character(selected_features$V2), "label")
selected_data <- mergedt[, selected_features]

# Summarising data - mean grouped by label and subject
summarised_data <- selected_data %>% group_by(label, subject) %>% summarise_each(funs(mean))

# Persist the data for upload
write.table(selected_data, "selected_data.tsv", row.names = FALSE, col.names = TRUE)
