# Introduction to xgboost (tutorial)
# https://xgboost.readthedocs.org/en/latest/R-package/xgboostPresentation.html

require(xgboost)

data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')

train <- agaricus.train
test <- agaricus.test

str(train)
str(test)

# basic training
bstSparse <- xgboost(
  data = train$data, 
  label = train$label, 
  max.depth = 2, 
  eta = 1, 
  nthread = 2, 
  nround = 2, 
  objective = "binary:logistic")

# Understand your data with xgboost
# https://xgboost.readthedocs.org/en/latest/R-package/discoverYourData.html
