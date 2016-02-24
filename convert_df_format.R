# ----------------------------------------------------------------------
# ex1 ------------------------------------------------------------------
# http://stackoverflow.com/questions/5890584/reshape-data-from-long-to-wide-format-r
# ----------------------------------------------------------------------
dat1 <- data.frame(
  name = rep(c("firstName", "secondName"), each=4),
  numbers = rep(1:4, 2),
  value = rnorm(8)
)

# timevar - the variable in long format that differentiates multiple records from the same group or individual. If more than one record matches, the first will be taken (with a warning).
# advar - Names of one or more variables in long format that identify multiple records from the same group/individual. These variables may also be present in wide format.
reshape(dat1, idvar = "name", timevar = "numbers", direction = "wide")

dat2 <- read.table(textConnection(
  "Code Country        1950    1951    1952    1953    1954
  AFG  Afghanistan    20,249  21,352  22,532  23,557  24,555
  ALB  Albania        8,097   8,986   10,058  11,123  12,246"), 
  header=TRUE)

reshape(dat2, 
        direction="long", 
        varying=list(names(dat2)[3:7]), 
        v.names="Value", 
        idvar=c("Code","Country"), 
        timevar="Year", 
        times=1950:1954)

# ----------------------------------------------------------------------
# ex2 ------------------------------------------------------------------
# http://www.ats.ucla.edu/stat/r/faq/reshape.htm
# ----------------------------------------------------------------------
dat <- read.table('http://www.ats.ucla.edu/stat/r/faq/hsb2.csv', header=T, sep=",") # df in 'wide' format
dat[1:10,]
dim(dat)

# Wide to long
l <- reshape(dat, 
             varying = c("read", "write", "math", "science", "socst"), 
             v.names = "score",
             timevar = "subj", 
             times = c("read", "write", "math", "science", "socst"), 
             new.row.names = 1:1000,
             direction = "long")

l.sort <- l[order(l$id),] # sort by id
l.sort[1:10,]
dim(l)

# Long to wide
w <- reshape(l.sort, 
             timevar = "subj",
             idvar = c("id", "female", "race", "ses", "schtyp", "prog"),
             direction = "wide")

w[1:10,]
dim(w)


# ----------------------------------------------------------------------
# ex3 ------------------------------------------------------------------
# http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/
# ----------------------------------------------------------------------

# data frame in 'wide' format
olddata_wide <- read.table(header=TRUE, text='
                          subject sex control cond1 cond2
                           1   M     7.9  12.3  10.7
                           2   F     6.3  10.6  11.1
                           3   F     9.5  13.1  13.8
                           4   M    11.5  13.4  12.9
                           ')
# Make sure the subject column is a factor
olddata_wide$subject <- factor(olddata_wide$subject)


# data frame in 'long' format
olddata_long <- read.table(header=TRUE, text='
                          subject sex condition measurement
                           1   M   control         7.9
                           1   M     cond1        12.3
                           1   M     cond2        10.7
                           2   F   control         6.3
                           2   F     cond1        10.6
                           2   F     cond2        11.1
                           3   F   control         9.5
                           3   F     cond1        13.1
                           3   F     cond2        13.8
                           4   M   control        11.5
                           4   M     cond1        13.4
                           4   M     cond2        12.9
                           ')
# Make sure the subject column is a factor
olddata_long$subject <- factor(olddata_long$subject)

# tidyr
# wide -> long
library(tidyr)

# long -> wide

# reshape2

# ----------------------------------------------------------------------
# ex4 ------------------------------------------------------------------
# http://rforpublichealth.blogspot.com/2013/02/converting-dataset-from-wide-to-long.html
# ----------------------------------------------------------------------



