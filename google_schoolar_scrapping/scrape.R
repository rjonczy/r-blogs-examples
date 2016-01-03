library(rvest)
library(ggplot2)

# -----
page <- read_html("https://scholar.google.com/citations?user=sTR9SIQAAAAJ&hl=en&oi=ao")

# http://selectorgadget.com/
citations <- page %>% 
  html_nodes("#gsc_a_b .gsc_a_c") %>% 
  html_text() %>% 
  as.numeric()

citations

barplot(citations, main="How many times has each paper been cited?", ylab='Number of citations', col="skyblue", xlab="")

# -----
page <- read_html("https://scholar.google.com/citations?view_op=list_colleagues&hl=en&user=sTR9SIQAAAAJ")

Coauthors <- page %>% 
  html_nodes(css=".gsc_1usr_name a") %>% 
  html_text()

Coauthors <- as.data.frame(Coauthors)

Coauthors$Coauthors <- as.character(Coauthors$Coauthors)
names(Coauthors) <- 'Coauthors'

head(Coauthors)
dim(Coauthors)
str(Coauthors)


# -----
page <- read_html("https://scholar.google.com/citations?view_op=list_colleagues&hl=en&user=sTR9SIQAAAAJ")

citations <- page %>% 
  html_nodes(css = ".gsc_1usr_cby") %>% 
  html_text()

citations 

citations <- gsub('Cited by','', citations)

citations <- as.numeric(citations)
citations <- as.data.frame(citations)


# -----
page <- read_html("https://scholar.google.com/citations?view_op=list_colleagues&hl=en&user=sTR9SIQAAAAJ")

affilation <- page %>% 
  html_nodes(css = ".gsc_1usr_aff") %>% 
  html_text()

affilation <- as.data.frame(affilation)
names(affilation) <- 'Affilation'

# -----
cauthors <- cbind(Coauthors, citations, affilation)
cauthors 

cauthors$Coauthors <- factor(cauthors$Coauthors, levels = cauthors$Coauthors[order(cauthors$citations, decreasing=F)])

ggplot(cauthors, aes(x = Coauthors, y = citations)) +
  geom_bar(stat="identity", fill="#ff8c1a", size=7) +
  theme(axis.title.y = element_blank()) +
  ylab("# of citations") +
  theme(plot.title = element_text(size = 18, colour="blue"), axis.text.y = element_text(colour="grey20", size=12)) +
  ggtitle('Citations of his coauthors') +
  coord_flip()

