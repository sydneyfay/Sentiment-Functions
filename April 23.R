library(readr)
library(ggplot2)
library(cowplot)
library(sentimentr)

train <- read_csv("Downloads/train.csv")
View(train)

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

train$clean <- clean(train)
g<- get_sentences(train$clean)
sentiment_by(g)
View(train$clean)

s1 <- calc_sentimentr(train$clean, polarity_dt = JR)
s1
s2 <- calc_sentimentr(train$clean, polarity_dt = Slang)
#s3 <- calc_sentimentr(train$clean, polarity_dt = JR_Slang)
s4 <- calc_sentimentr(train$clean, polarity_dt = JR_HES)

df <- data.frame(category = factor(train$sentiment), score = s1$ave_sentiment)
head(df)
p <- ggplot(df,aes(category,score,fill = category)) + geom_boxplot()+
  theme_classic() + theme(legend.position = "none") +
  ggtitle("Jockers Rinker")
p
df2 <- data.frame(category = factor(train$sentiment), score = s2$ave_sentiment)
p2 <- ggplot(df2,aes(category,score,fill = category)) + geom_boxplot()+
  theme_classic() + theme(legend.position = "none") +
  ggtitle("Slang")
p2
