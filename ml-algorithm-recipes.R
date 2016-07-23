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





