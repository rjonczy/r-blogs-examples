library(datasets)
head(iris)

library(ggplot2)
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) + geom_point()


set.seed(20)
# for clustering we use only Petal.Length and Petal.Width
irisCluster <- kmeans(iris[, 3:4], 3, nstart = 20)
irisCluster

# compare (3 -setosa, 2 -virginica, 1 -versicolor)
table(irisCluster$cluster, iris$Species)


iris$cluster <- as.factor(irisCluster$cluster)
ggplot(iris, aes(Petal.Length, Petal.Width, color = iris$cluster)) + geom_point()








