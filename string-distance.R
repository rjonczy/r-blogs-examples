# http://amunategui.github.io/stringdist/index.html

library(RCurl)
library(stringdist)

urlfile <-'https://raw.githubusercontent.com/hadley/fueleconomy/master/data-raw/vehicles.csv'
x <- getURL(urlfile, ssl.verifypeer = FALSE)
vehicles <- read.csv(textConnection(x))

# alternative way of getting the data if the above snippet doesn't work:
# urlData <- getURL('https://raw.githubusercontent.com/hadley/fueleconomy/master/data-raw/vehicles.csv')
# vehicles <- read.csv(text = urlData)

nrow(vehicles)
dim(vehicles)
str(vehicles)

length(unique(vehicles$model))


vehicles_small <- vehicles[1:100,]
length(unique(vehicles_small$model))

head(unique(as.character(vehicles_small$model)))

uniquemodels <- unique(as.character(vehicles_small$model))
distancemodels <- stringdistmatrix(uniquemodels, uniquemodels, method = "jw")

rownames(distancemodels) <- uniquemodels
colnames(distancemodels) <- uniquemodels

# as.dist(takes only half of matrix)
hc <- hclust(as.dist(distancemodels))
plot(hc)
rect.hclust(hc, k = 5) #rect.hclust(hc, h = .5)



vehicles_small <- vehicles[1:2000,]
length(unique(vehicles_small$model))


uniquemodels <- unique(as.character(vehicles_small$model))
distancemodels <- stringdistmatrix(uniquemodels, uniquemodels, method = "jw")
rownames(distancemodels) <- uniquemodels
hc <- hclust(as.dist(distancemodels))
dfClust <- data.frame(uniquemodels, cutree(hc, k=200))
names(dfClust) <- c('modelname', 'cluster')

plot(table(dfClust$cluster))

print(paste('Average number of models per cluster:', mean(table(dfClust$cluster))))


t <- table(dfClust$cluster)
t <- cbind(t, t/length(dfClust$cluster))
t <- t[order(t[,2], decreasing=TRUE),]
p <- data.frame(factorName=rownames(t), binCount=t[,1], percentFound=t[,2])
dfClust <- merge(x=dfClust, y=p, by.x = 'cluster', by.y='factorName', all.x=T)
dfClust <- dfClust[rev(order(dfClust$binCount)),]
names(dfClust) <-  c('cluster', 'modelname')
head(dfClust[c('cluster', 'modelname')], 50)


vehicles_small$modelAndTrany <- paste0(as.character(vehicles_small$model), " ", as.character(vehicles_small$trany))
print(length(unique(vehicles_small$modelAndTrany)))


uniquemodels <- unique(as.character(vehicles_small$modelAndTrany))
distancemodels <- stringdistmatrix(uniquemodels, uniquemodels, method = "jw")
rownames(distancemodels) <- uniquemodels
hc <- hclust(as.dist(distancemodels))


dfClust <- data.frame(uniquemodels, cutree(hc, k=500))

plot(table(dfClust$cluster))

names(dfClust) <- c('modelname', 'cluster')
t <- table(dfClust$cluster)
t <- cbind(t, t/length(dfClust$cluster))
t <- t[order(t[,2], decreasing=TRUE),]
p <- data.frame(factorName=rownames(t), binCount=t[,1], percentFound=t[,2])
dfClust <- merge(x=dfClust, y=p, by.x = 'cluster', by.y='factorName', all.x=T)
dfClust <- dfClust[rev(order(dfClust$binCount)),]
names(dfClust) <-  c('cluster', 'modelname')
head(dfClust[c('cluster','modelname')], 50)

