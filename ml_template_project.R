# http://machinelearningmastery.com/machine-learning-in-r-step-by-step/
# install.packages("caret", dependencies=c("Depends", "Suggests"))
library(caret)

data(iris)
dataset <- iris

# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- dataset[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset <- dataset[validation_index,]


# dimensions of dataset
dim(dataset)

# types of attributes
str(dataset)
sapply(dataset, class)

# check data
head(dataset)
tail(dataset)


# levels of Class
# This is a multi-class or a multinomial classification problem. If there were two levels, it would be a binary classification problem.
levels(dataset$Species)

# summarise the class distribution
percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)

# summarise attributes distribution
summary(dataset)


x <- dataset[,1:4]
y <- dataset[,5]


par(mfrow = c(1,4))
for(i in 1:4) {
  boxplot(x[,i], main = names(iris)[i])
}

par(mfrow = c(1,1))
plot(y)

featurePlot(x=x, y=y, plot="ellipse")
featurePlot(x=x, y=y, plot="box")

# density plots for each attribute by class value
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)
