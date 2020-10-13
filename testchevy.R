library(sentimentr)
library(readr)
library(ggplot2)
library(cowplot)

source("sentiment_functions.R")
library(readr)
chevrolet_tweets<- read_csv("chevrolet_tweets_2020-10-06-16:18:28.RData.csv")
View(chevrolet_tweets)

chevrolet <- clean(chevrolet_tweets)
g<- get_sentences(chevrolet)
sentiment_by(g)

JR <- lexicon::hash_sentiment_jockers_rinker
ES <- lexicon::emojis_sentiment
HES <- lexicon::hash_sentiment_emojis
Slang <- lexicon::hash_sentiment_slangsd
JR_Slang <- rbind(lexicon::hash_sentiment_jockers_rinker,lexicon::hash_sentiment_slangsd)

JR_HES <- combine_dictionaries(JR, HES)
JR_Slang <- combine_dictionaries(JR,Slang)

#Using JR/HES because it was most accurate according to ROC
s <- calc_sentimentr(chevrolet, polarity_dt = JR_HES)
View(s)
plot(1:3523, s$ave_sentiment )




