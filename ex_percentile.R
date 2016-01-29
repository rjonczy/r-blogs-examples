# http://stats.stackexchange.com/questions/156778/percentile-vs-quantile-vs-quartile

# http://www.r-tutor.com/elementary-statistics/numerical-measures/quartile
# http://www.r-tutor.com/elementary-statistics/numerical-measures/percentile

# 0 quartile = 0 quantile = 0 percentile
# 1 quartile = 0.25 quantile = 25 percentile
# 2 quartile = .5 quantile = 50 percentile (median)
# 3 quartile = .75 quantile = 75 percentile
# 4 quartile = 1 quantile = 100 percentile

# The n-th percentile of an observation variable is the value that cuts off the first n percent 
# of the data values when it is sorted in ascending order. 


# Percentiles
median(faithful$eruptions)
range(faithful$eruptions)
quantile(faithful$eruptions, c(.32, .57, .98))
quantile(faithful$eruptions, c(.17, .43, .67, .85))

# Quartiles
quantile(faithful$eruptions)


