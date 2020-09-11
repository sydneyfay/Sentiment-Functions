library(sentimentr)
library(readr)
library(ggplot2)
library(cowplot)

source("sentiment_functions.R")

View(lexicon::hash_emojis_identifier)
JR <- lexicon::hash_sentiment_jockers_rinker
ES <- lexicon::emojis_sentiment
HES <- lexicon::hash_sentiment_emojis
Slang <- lexicon::hash_sentiment_slangsd
JR_Slang <- rbind(lexicon::hash_sentiment_jockers_rinker,lexicon::hash_sentiment_slangsd)

JR_HES <- combine_dictionaries(JR, HES)
JR_Slang <- combine_dictionaries(JR,Slang)
View(JR_Slang)

train <- read_csv("data/train.csv")
View(train)

train$clean <- clean(train)
g<- get_sentences(train$clean)
sentiment_by(g)
View(train$clean)

s1 <- calc_sentimentr(train$clean, polarity_dt = JR)
s1
s2 <- calc_sentimentr(train$clean, polarity_dt = Slang)
s3 <- calc_sentimentr(train$clean, polarity_dt = JR_Slang)

s4 <- calc_sentimentr(train$clean, polarity_dt = JR_HES)
s5 <- calc_sentimentr(train$clean, polarity_dt = HES)
  
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

#df3 <- data.frame(category = factor(train$sentiment), score = s3$ave_sentiment)


table(train$sentiment)
