library(expsmooth)

# https://www.linkedin.com/pulse/exponential-smoothing-time-series-data-r-strickland-ph-d-cmsp

#Though I have discussed other components of time series data, we can describe most time series patterns in terms of two basic classes of components: trend and seasonality. 
#The former represents a general systematic linear or nonlinear component that changes over time and does not repeat, 
# or at least does not repeat within the time range captured by our data (e.g., a plateau followed by a period of exponential growth). 
#The latter may have a formally similar nature; however, it repeats itself in systematic intervals over time. 
#These two general classes of time series components may coexist in real-life data. 

data(unemp.cci)

cci <- ts(unemp.cci[,"cci"], start = c(1997))
plot.ts(cci)


# beta = TRUE =>  exponential smoothing with TREND
# beta = FALSE =>  exponential smoothing without TREND 
# gamma is a parameter used for the seasonal component
# gamma = FALSE => a non-seasonal model is fitted
# gamma = TRUE => a seasonal model is fitted

# Single Exponential Smoothing
cci.smooth <- HoltWinters(cci, beta=FALSE, gamma=FALSE)
plot(cci.smooth$fitted)

# Double Expotential Smoothing
cci.smoother<- HoltWinters(cci, gamma=FALSE)
plot(cci.smoother$fitted)
