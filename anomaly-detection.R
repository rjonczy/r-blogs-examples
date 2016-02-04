# anomallly detection based on twitters package AnomalyDetection
# https://github.com/twitter/AnomalyDetection

#install.packages("devtools")
#devtools::install_github("twitter/AnomalyDetection")
library(AnomalyDetection)

# get help
help(package = 'AnomalyDetection')
help(AnomalyDetectionTs)
help(AnomalyDetectionVec)

# load example data
data(raw_data)

res <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', plot=TRUE)
res$plot

AnomalyDetectionVec(raw_data[,2], max_anoms=0.02, period=1440, direction='both', only_last=FALSE, plot=TRUE)

res <- AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', only_last='day', plot=TRUE)
res$plot

