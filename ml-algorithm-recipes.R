# http://machinelearningmastery.com/how-to-get-started-with-machine-learning-algorithms-in-r/
# Algorithm recipes in R


# Linear Regression in R -------------------------------------------------------


### Ordinary Least Squares Regression ###

# Ordinary Least Squares (OLS) regression is a linear model that seeks to find a set of coefficients for a line/hyper-plane that minimise the sum of the squared errors.

# load data
data(longley)
# fit model
fit <- lm(Employed ~ ., longley)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

### Stepwize Linear Regression ###

# Stepwise Linear Regression is a method that makes use of linear regression to discover which subset of attributes in the dataset result in the best performing model. It is step-wise because each iteration of the method makes a change to the set of attributes and creates a model to evaluate the performance of the set.

# load data
data(longley)
# fit model
base <- lm(Employed~., longley)
# summarize the fit
summary(base)
# perform step-wise feature selection
fit <- step(base)
# summarize the selected model
summary(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)

### Principal Component Regression ###

# Principal Component Regression (PCR) creates a linear regression model using the outputs of a Principal Component Analysis (PCA) to estimate the coefficients of the model. PCR is useful when the data has highly-correlated predictors.

# load the package
library(pls)
# load data
data(longley)
# fit model
fit <- pcr(Employed~., data=longley, validation="CV")
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley, ncomp=6)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)


### Partial Least Squares Regression ###

# Partial Least Squares (PLS) Regression creates a linear model of the data in a transformed projection of problem space. Like PCR, PLS is appropriate for data with highly-correlated predictors.

# load the package
library(pls)
# load data
data(longley)
# fit model
fit <- plsr(Employed~., data=longley, validation="CV")
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley, ncomp=6)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)





# Penalized Regression in R -----------------------------------------------


### Ridge Regression ###

# Ridge Regression creates a linear regression model that is penalized with the L2-norm which is the sum of the squared coefficients. This has the effect of shrinking the coefficient values (and the complexity of the model) allowing some coefficients with minor contribution to the response to get close to zero.

# load the package
library(glmnet)
# load data
data(longley)
x <- as.matrix(longley[,1:6])
y <- as.matrix(longley[,7])
# fit model
fit <- glmnet(x, y, family="gaussian", alpha=0, lambda=0.001)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, x, type="link")
# summarize accuracy
rmse <- mean((y - predictions)^2)
print(rmse)

### Least Absolute Shrinkage and Selection Operator ###

# Least Absolute Shrinkage and Selection Operator (LASSO) creates a regression model that is penalized with the L1-norm which is the sum of the absolute coefficients. This has the effect of shrinking coefficient values (and the complexity of the model), allowing some with a minor affect to the response to become zero.

# load the package
library(lars)
# load data
data(longley)
x <- as.matrix(longley[,1:6])
y <- as.matrix(longley[,7])
# fit model
fit <- lars(x, y, type="lasso")
# summarize the fit
summary(fit)
# select a step with a minimum error
best_step <- fit$df[which.min(fit$RSS)]
# make predictions
predictions <- predict(fit, x, s=best_step, type="fit")$fit
# summarize accuracy
rmse <- mean((y - predictions)^2)
print(rmse)


### Elastic Net ###

# Elastic Net creates a regression model that is penalized with both the L1-norm and L2-norm. This has the effect of effectively shrinking coefficients (as in ridge regression) and setting some coefficients to zero (as in LASSO).

# load the package
library(glmnet)
# load data
data(longley)
x <- as.matrix(longley[,1:6])
y <- as.matrix(longley[,7])
# fit model
fit <- glmnet(x, y, family="gaussian", alpha=0.5, lambda=0.001)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, x, type="link")
# summarize accuracy
rmse <- mean((y - predictions)^2)
print(rmse)






# Non-Linear Regression in R ----------------------------------------------

### Multivariate Adaptive Regression Splines ###

# Multivariate Adaptive Regression Splines (MARS) is a non-parametric regression method that models multiple nonlinearities in data using hinge functions (functions with a kink in them).

# load the package
library(earth)
# load data
data(longley)
# fit model
fit <- earth(Employed~., longley)
# summarize the fit
summary(fit)
# summarize the importance of input variables
evimp(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)


### Support Vector Machine ###

# Support Vector Machines (SVM) are a class of methods, developed originally for classification, that find support points that best separate classes. SVM for regression is called Support Vector Regression (SVM).

# load the package
library(kernlab)
# load data
data(longley)
# fit model
fit <- ksvm(Employed~., longley)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley)
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)


### k-Nearest Neighbor ###

# The k-Nearest Neighbor (kNN) does not create a model, instead it creates predictions from close data on-demand when a prediction is required. A similarity measure (such as Euclidean distance) is used to locate close data in order to make predictions.

# load the package
library(caret)
# load data
data(longley)
# fit model
fit <- knnreg(longley[,1:6], longley[,7], k=3)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, longley[,1:6])
# summarize accuracy
rmse <- mean((longley$Employed - predictions)^2)
print(rmse)


### Neural Network ###

# A Neural Network (NN) is a graph of computational units that recieve inputs and transfer the result into an output that is passed on. The units are ordered into layers to connect the features of an input vector to the features of an output vector. With training, such as the Back-Propagation algorithm, neural networks can be designed and trained to model the underlying relationship in data.

# load the package
library(nnet)
# load data
data(longley)
x <- longley[,1:6]
y <- longley[,7]
# fit model
fit <- nnet(Employed~., longley, size=12, maxit=500, linout=T, decay=0.01)
# summarize the fit
summary(fit)
# make predictions
predictions <- predict(fit, x, type="raw")
# summarize accuracy
rmse <- mean((y - predictions)^2)
print(rmse)