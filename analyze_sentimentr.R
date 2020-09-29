library(sentimentr)
library(readr)
library(ggplot2)
library(cowplot)

source("sentiment_functions.R")

JR <- lexicon::hash_sentiment_jockers_rinker
ES <- lexicon::emojis_sentiment
HES <- lexicon::hash_sentiment_emojis
Slang <- lexicon::hash_sentiment_slangsd
JR_Slang <- rbind(lexicon::hash_sentiment_jockers_rinker,lexicon::hash_sentiment_slangsd)

JR_HES <- combine_dictionaries(JR, HES)
JR_Slang <- combine_dictionaries(JR,Slang)

train <- read_csv("data/train.csv")

train$clean <- clean(train)
g<- get_sentences(train$clean)
sentiment_by(g)

s1 <- calc_sentimentr(train$clean, polarity_dt = JR)
s2 <- calc_sentimentr(train$clean, polarity_dt = Slang)
s3 <- calc_sentimentr(train$clean, polarity_dt = JR_Slang)
s4 <- calc_sentimentr(train$clean, polarity_dt = JR_HES)
s5 <- calc_sentimentr(train$clean, polarity_dt = HES)
  
df <- data.frame(category = factor(train$sentiment), score = s1$ave_sentiment)
df2 <- data.frame(category = factor(train$sentiment), score = s2$ave_sentiment)
df3 <- data.frame(category = factor(train$sentiment), score = s3$ave_sentiment)
df4 <- data.frame(category = factor(train$sentiment), score = s4$ave_sentiment)
df5 <- data.frame(category = factor(train$sentiment), score = s5$ave_sentiment)

p1 <- plotData(df, "Jockers Rinker")
p1

p2 <- plotData(df2, "Slang")
p2

p3 <- plotData(df3, "JR Slang")
p3

p4 <- plotData(df4, "JR HES")
p4
table(train$sentiment)
