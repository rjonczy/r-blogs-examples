# http://rtutorialseries.blogspot.com/2012/03/r-tutorial-series-centering-variables.html


dataScale <- read.csv("dataset_scale.csv")
head(dataScale)



# Centering Variables

# Normally, to center a variable, you would subtract the mean of all data points from each individual data point. 
# With scale(), this can be accomplished in one simple call.

#center variable A using the scale() function
scale(dataScale$A, center = TRUE, scale = FALSE)

#center variable A manually to verify the results
dataScale$A - mean(dataScale$A)




# Generating Z-Scores

#generate z-scores for variable A using the scale() function<
scale(dataScale$A, center = TRUE, scale = TRUE)

#generate z-scores for variable A manually to verify the results
( dataScale$A - mean(dataScale$A) ) / sd(dataScale$A)
