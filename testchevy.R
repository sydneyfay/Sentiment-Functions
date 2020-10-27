library(sentimentr)
library(readr)
library(ggplot2)
library(cowplot)
library(keras)
library(tensorflow)
library(gridExtra)

source("sentiment_functions.R")
library(readr)
chevrolet_tweets<- read_csv("tweets 10.9.20/chevrolet_tweets_2020-10-09-15:47:00.csv")

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

plot(1:3600, s$ave_sentiment )

hist(s$ave_sentiment)
c <- ggplot(s, aes(x = ave_sentiment)) + geom_histogram(fill = "darkblue",binwidth = 0.3) + theme_classic() + ggtitle("Chevrolet")


#######################
dodge_tweets <- read_csv("tweets 10.9.20/dodge_tweets_2020-10-09-15:44:58.csv")

dodge <- clean(dodge_tweets)
g<- get_sentences(dodge)
sentiment_by(g)

s_d <- calc_sentimentr(dodge, polarity_dt = JR_HES)
View(s_d)

d <- ggplot(s_d, aes(x = ave_sentiment)) + geom_histogram(fill = "darkblue",binwidth = 0.3)+ theme_classic() + ggtitle("Dodge")
###################
fordTweets <- read_csv("tweets 10.9.20/fordTweets_2020-10-09-15:46:24.csv")

ford <- clean(fordTweets)
g<- get_sentences(ford)
sentiment_by(g)

s_f <- calc_sentimentr(ford, polarity_dt = JR_HES)
View(s_f)

f <- ggplot(s_f, aes(x = ave_sentiment)) + geom_histogram(fill = "darkblue",binwidth = 0.3) + theme_classic() + ggtitle("Ford")
####################
honda_tweets <- read_csv("tweets 10.9.20/honda_tweets_2020-10-09-15:45:37.csv")

honda <- clean(honda_tweets)
g<- get_sentences(honda)
sentiment_by(g)

s_h <- calc_sentimentr(honda, polarity_dt = JR_HES)
h <- ggplot(s_h, aes(x = ave_sentiment)) + geom_histogram(fill = "darkblue",binwidth = 0.3) + theme_classic() + ggtitle("Honda")
######################
toyota_tweets <- read_csv("tweets 10.9.20/toyota_tweets_2020-10-09-15:43:23.csv")

toyota <- clean(toyota_tweets)
g<- get_sentences(toyota)
sentiment_by(g)

s_t <- calc_sentimentr(toyota, polarity_dt = JR_HES)
t <- ggplot(s_t, aes(x = ave_sentiment)) + geom_histogram(fill = "darkblue", binwidth = 0.3) + theme_classic() + ggtitle("Toyota")

#######################

grid.arrange(c,d,f,h,t, nrow = 2)



