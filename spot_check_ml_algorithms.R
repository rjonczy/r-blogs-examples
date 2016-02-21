# http://machinelearningmastery.com/spot-check-machine-learning-algorithms-in-r/

# --------------------------------------------------------------
# Linear
# --------------------------------------------------------------


# --------------------------------------------------------------
# Linear Regression
# --------------------------------------------------------------
# load the library
library(mlbench)
# load data
data(BostonHousing)
# fit model
fit <- lm(medv ~ . , BostonHousing)
# summarize the fit
print(fit)
summary(fit)
# make predictions
predictions <- predict(fit, BostonHousing)
# summarize accuracy
mse <- mean((BostonHousing$medv - predictions)^2)
print(mse)
# --------------------------------------------------------------
# load libraries
library(caret)
library(mlbench)
# load dataset
data(BostonHousing)
# train
set.seed(7)
control <- trainControl(method="cv", number=5)
fit.lm <- train(medv ~ ., data=BostonHousing, method="lm", metric="RMSE", preProc=c("center", "scale"), trControl=control)
# summarize fit
print(fit.lm)
# --------------------------------------------------------------


# --------------------------------------------------------------
# Logistic Regression
# --------------------------------------------------------------
# load the library
library(mlbench)
# Load the dataset
data(PimaIndiansDiabetes)
# fit model
fit <- glm(diabetes ~ ., data=PimaIndiansDiabetes, family=binomial(link='logit'))
# summarize the fit
print(fit)
summary(fit)
# make predictions
probabilities <- predict(fit, PimaIndiansDiabetes[,1:8], type='response')
predictions <- ifelse(probabilities > 0.5,'pos','neg')
# summarize accuracy
table(predictions, PimaIndiansDiabetes$diabetes)
# --------------------------------------------------------------
# load libraries
library(caret)
library(mlbench)
# Load the dataset
data(PimaIndiansDiabetes)
# train
set.seed(7)
control <- trainControl(method="cv", number=10)
fit.glm <- train(diabetes ~ ., data=PimaIndiansDiabetes, method="glm", metric="Accuracy", preProc=c("center", "scale"), trControl=control)
# summarize fit
print(fit.glm)

# --------------------------------------------------------------


# --------------------------------------------------------------
# Linear Discriminant Analysis
# --------------------------------------------------------------
# load the libraries
library(MASS)
library(mlbench)
# Load the dataset
data(PimaIndiansDiabetes)
# fit model
fit <- lda(diabetes ~ ., data=PimaIndiansDiabetes)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, PimaIndiansDiabetes[,1:8])$class
# summarize accuracy
table(predictions, PimaIndiansDiabetes$diabetes)
# --------------------------------------------------------------
# load libraries
library(caret)
library(mlbench)
# Load the dataset
data(PimaIndiansDiabetes)
# train
set.seed(7)
control <- trainControl(method="cv", number=5)
fit.lda <- train(diabetes ~ ., data=PimaIndiansDiabetes, method="lda", metric="Accuracy", preProc=c("center", "scale"), trControl=control)
# summarize fit
print(fit.lda)
# --------------------------------------------------------------



# --------------------------------------------------------------
# Regularized Regression
# --------------------------------------------------------------
# Classification Example:
# load the library
library(glmnet)
library(mlbench)
# load data
data(PimaIndiansDiabetes)
x <- as.matrix(PimaIndiansDiabetes[,1:8])
y <- as.matrix(PimaIndiansDiabetes[,9])
# fit model
fit <- glmnet(x, y, family="binomial", alpha=0.5, lambda=0.001)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, x, type="class")
# summarize accuracy
table(predictions, PimaIndiansDiabetes$diabetes)
# It can also be configured to perform three important types of regularization: lasso, ridge and elastic net by configuring the alpha parameter to 1, 0 or in [0,1] respectively.
# --------------------------------------------------------------
# Regression Example:
# load the libraries
library(glmnet)
library(mlbench)
# load data
data(BostonHousing)
BostonHousing$chas <- as.numeric(as.character(BostonHousing$chas))
x <- as.matrix(BostonHousing[,1:13])
y <- as.matrix(BostonHousing[,14])
# fit model
fit <- glmnet(x, y, family="gaussian", alpha=0.5, lambda=0.001)
# summarize the fit
print(fit)
# make predictions
predictions <- predict(fit, x, type="link")
# summarize accuracy
mse <- mean((y - predictions)^2)
print(mse)

# --------------------------------------------------------------
# Classification Example (caret)
# load libraries
library(caret)
library(mlbench)
library(glmnet)
# Load the dataset
data(PimaIndiansDiabetes)
# train
set.seed(7)
control <- trainControl(method="cv", number=5)
fit.glmnet <- train(diabetes~., data=PimaIndiansDiabetes, method="glmnet", metric="Accuracy", preProc=c("center", "scale"), trControl=control)
# summarize fit
print(fit.glmnet)
# --------------------------------------------------------------
# Regression Example (caret)
# load libraries
library(caret)
library(mlbench)
library(glmnet)
# Load the dataset
data(BostonHousing)
# train
set.seed(7)
control <- trainControl(method="cv", number=5)
fit.glmnet <- train(medv ~ ., data=BostonHousing, method="glmnet", metric="RMSE", preProc=c("center", "scale"), trControl=control)
# summarize fit
print(fit.glmnet)




# --------------------------------------------------------------




# --------------------------------------------------------------
# Non-Linear
# --------------------------------------------------------------






# --------------------------------------------------------------
# k-Nearest Neighbors
# --------------------------------------------------------------
# Classification
# knn direct classification

# load the libraries
library(caret)
library(mlbench)

# Load the dataset
data(PimaIndiansDiabetes)

# fit model
fit <- knn3(diabetes ~ ., data=PimaIndiansDiabetes, k=3)

# summarize the fit
print(fit)

# make predictions
predictions <- predict(fit, PimaIndiansDiabetes[,1:8], type="class")

# summarize accuracy
table(predictions, PimaIndiansDiabetes$diabetes)

# --------------------------------------------------------------
# Regression

# load the libraries
library(caret)
library(mlbench)

# load data
data(BostonHousing)
BostonHousing$chas <- as.numeric(as.character(BostonHousing$chas))
x <- as.matrix(BostonHousing[,1:13])
y <- as.matrix(BostonHousing[,14])

# fit model
fit <- knnreg(x, y, k=3)

# summarize the fit
print(fit)
summary(fit)

# make predictions
predictions <- predict(fit, x)

# summarize accuracy
mse <- mean((BostonHousing$medv - predictions)^2)
print(mse)


# --------------------------------------------------------------
# Classification (caret)

# load libraries
library(caret)
library(mlbench)

# Load the dataset
data(PimaIndiansDiabetes)

# train
set.seed(7)
control <- trainControl(method="cv", number=5)
fit.knn <- train(diabetes ~ ., data=PimaIndiansDiabetes, method="knn", metric="Accuracy", preProc=c("center", "scale"), trControl=control)

# summarize fit
print(fit.knn)
summary(fit.knn)

# --------------------------------------------------------------
# Regression (caret)

# load libraries
library(caret)

# Load the dataset
data(BostonHousing)

# train
set.seed(7)
control <- trainControl(method="cv", number=5)
fit.knn <- train(medv~., data=BostonHousing, method="knn", metric="RMSE", preProc=c("center", "scale"), trControl=control)

# summarize fit
print(fit.knn)
summary(fit.knn)

# --------------------------------------------------------------





# --------------------------------------------------------------
# Naive Bayes
# --------------------------------------------------------------

# load the libraries
library(e1071)
library(mlbench)

# Load the dataset
data(PimaIndiansDiabetes)

# fit model
fit <- naiveBayes(diabetes~., data=PimaIndiansDiabetes)

# summarize the fit
print(fit)

# make predictions
predictions <- predict(fit, PimaIndiansDiabetes[,1:8])

# summarize accuracy
table(predictions, PimaIndiansDiabetes$diabetes)

# --------------------------------------------------------------

# load libraries
library(caret)
library(mlbench)

# Load the dataset
data(PimaIndiansDiabetes)

# train
set.seed(7)
control <- trainControl(method="cv", number=5)
fit.nb <- train(diabetes~., data=PimaIndiansDiabetes, method="nb", metric="Accuracy", trControl=control)

# summarize fit
print(fit.nb)

# --------------------------------------------------------------

# --------------------------------------------------------------
# Support Vector Machine
# --------------------------------------------------------------
# --------------------------------------------------------------
# --------------------------------------------------------------


# --------------------------------------------------------------
# Classification and Regression Trees
# --------------------------------------------------------------
# --------------------------------------------------------------
# --------------------------------------------------------------


