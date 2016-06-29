# https://blog.rstudio.org/2014/11/24/rvest-easy-web-scraping-with-r/

library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")

# 
vignette("selectorgadget")

# extract rating
lego_movie %>% 
  html_node("strong span") %>%
  html_text() %>%
  as.numeric()

# extract cast
lego_movie %>%
  html_nodes("#titleCast .itemprop span") %>%
  html_text()

# extract titles & authors of board posts
lego_movie %>%
  html_nodes("table") %>%
  .[[3]] %>%
  html_table()


demo(package = "rvest")
