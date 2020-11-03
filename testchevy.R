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
HES <- lexicon::hash_sentiment_emojis

JR_HES <- combine_dictionaries(JR, HES)
s <- calc_sentimentr(chevrolet, polarity_dt = JR_HES)
View(s)

i <- which.min(s$ave_sentiment)
chevrolet[i]
i <- which.max(s$ave_sentiment)
chevrolet[i]
highlight(s)
#plot(1:3600, s$ave_sentiment )

hist(s$ave_sentiment)
c <- ggplot(s, aes(x = ave_sentiment)) + geom_histogram(fill = "darkblue",binwidth = 0.3) + theme_classic() + ggtitle("Chevrolet")
c

#######################
dodge_tweets <- read_csv("tweets 10.9.20/dodge_tweets_2020-10-09-15:44:58.csv")

dodge <- clean(dodge_tweets)
g<- get_sentences(dodge)
sentiment_by(g)

s_d <- calc_sentimentr(dodge, polarity_dt = JR_HES)
View(s_d)
d <- which.min(s_d$ave_sentiment)
dodge[d]
d <- which.max(s_d$ave_sentiment)
dodge[d]

highlight(s_d)
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

#grid.arrange(c,d,f,h,t, nrow = 2)
make.df <- function(car, sent) {
  data.frame(car = car, sent = sent$ave_sentiment)
}

all_results <- rbind(
  make.df('Chevrolet', s),
  make.df('Dodge', s_d),
  make.df('Ford', s_f),
  make.df('Honda',s_h),
  make.df('Toyota', s_t)
  
)

ggplot(all_results, aes(car,sent, fill = car)) + geom_boxplot() + xlab('Manufacturer') + ylab('Sentiment') + 
  theme_classic() + ggtitle('Sentiment by Manufacturer October 9th, 2020') + theme(legend.position = "none")

oct9result <- all_results %>% group_by(car) %>% 
  summarize(n = n())
###############################
chevrolet8 <- read_csv("tweets 10.8.20/chevrolet_tweets_2020-10-08-12:09:56.csv")
dodge8 <- read_csv("tweets 10.8.20/dodge_tweets_2020-10-08-12:08:31.csv")
ford8<- read_csv("tweets 10.8.20/fordTweets_2020-10-08-12:11:34.csv")
honda8<- read_csv("tweets 10.8.20/honda_tweets_2020-10-08-12:09:15.csv")
toyota8<- read_csv("tweets 10.8.20/toyota_tweets_2020-10-08-12:10:49.csv")

chevrolet8 <- clean(chevrolet8)
dodge8 <- clean(dodge8)
ford8 <- clean(ford8)
honda8 <- clean(honda8)
toyota8 <- clean(toyota8)


sc <- calc_sentimentr(chevrolet8, polarity_dt = JR_HES)
sd <- calc_sentimentr(dodge8, polarity_dt = JR_HES)
sh <- calc_sentimentr(honda8, polarity_dt = JR_HES)
sf <- calc_sentimentr(ford8, polarity_dt = JR_HES)
st <- calc_sentimentr(toyota8, polarity_dt = JR_HES)

all_results <- rbind(
  make.df('Chevrolet', sc),
  make.df('Dodge', sd),
  make.df('Ford', sf),
  make.df('Honda',sh),
  make.df('Toyota', st)
)

ggplot(all_results, aes(car,sent, fill = car)) + geom_boxplot() + xlab('Manufacturer') + ylab('Sentiment') + 
  theme_classic() + ggtitle('Sentiment by Manufacturer October 8th, 2020') + theme(legend.position = "none")
oct8result <- all_results %>% group_by(car) %>% 
  summarize(n = n())
oct8result
oct9result
save(oct8result, file = "oct8results")
save(oct9result, file = "oct9result")
