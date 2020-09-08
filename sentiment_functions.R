library(sentimentr)

calc_sentimentr <- function(x, ...) {
  
  #use replace emoji identifier
  replace_emoji_identifier(x, emoji_dt = lexicon::hash_emojis_identifier)
  sentcalc <- get_sentences(x)
  sentcalc <- sentiment_by(sentcalc, ...)
  sentcalc
}

combine_dictionaries <- function(x,y) {
    combined <- rbind(x,y)
    o <- order(combined$x)
    combined <- combined[o,]
    attr(combined, "sorted") <- "x"
    combined
}

clean <- function(train) {
  cleantweets = gsub('http\\S+\\s*',"", train$text)
  cleantweets = gsub('@\\w+',"", cleantweets)
  cleantweets = gsub('http.*',"", cleantweets)
  cleantweets = gsub('&amp;', "", cleantweets)
  # cleantweets = gsub('[[:punct:]]', '', cleantweets)
  cleantweets = gsub('%\\S+\\s*', "", cleantweets)
  #cleantweets = gsub('Ì\\w+',"", cleantweets)
  #cleantweets = gsub('Ò',"", cleantweets)
  cleantweets = gsub('RT\\s?@\\w+', '', cleantweets)
  #cleantweets = gsub('ü\\S+\\s*',"", cleantweets)
}

# samples data after stratifying by 'column' to return
# data containing 'num' samples in each group
sample_data <- function(d, column = 'X1', num = 100) {
  
  s <- split(d, d[[column]])
  
  # randomly sample 'num' rows of 'd'
  get_sample <-function(d, num) {
    s <- sample(1:nrow(d),num)
    d[s,]
  }
  
  # get sample for each group (e.g., positive/negative)
  l <- lapply(s, get_sample, num = num)
  
  # combine each group into a single table
  res <- do.call(rbind, l)
  res 
}
