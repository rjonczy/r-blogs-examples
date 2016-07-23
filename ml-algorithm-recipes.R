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

