library(readr)
############################################
# Chevrolet #
############################################
chevrolet1 <- read_csv("twitter data/10.8/chevrolet_tweets_2020-10-08-12:09:56.csv")
chevrolet2<- read_csv("twitter data/10.9/chevrolet_tweets_2020-10-09-15:47:00.csv")
chevrolet3 <- read_csv("twitter data/10.19/chevrolet_tweets_2020-10-19-13:10:43.csv")
chevrolet4 <- read_csv("twitter data/10.21/chevrolet_tweets_2020-10-21-13:15:35.csv")
chevrolet5 <- read_csv("twitter data/10.22/chevrolet_tweets_2020-10-22-13:57:48.csv")
chevrolet6 <- read_csv("twitter data/10.23/chevrolet_tweets_2020-10-23-11:52:56.csv")
chevrolet7<- read_csv("twitter data/10.6/chevrolet_tweets_2020-10-06-16:18:28.RData.csv")

chevy <- as.data.frame(rbind(chevrolet1,chevrolet2,chevrolet3,chevrolet4,chevrolet5,chevrolet6,chevrolet7))

chevy <- clean(chevy)
c <- calc_sentimentr(chevy, polarity_dt = JR_HES)

############################################
# Dodge #
############################################
d1<- read_csv("twitter data/10.21/dodge_tweets_2020-10-21-13:16:27.csv")
d2<- read_csv("twitter data/10.22/dodge_tweets_2020-10-22-13:56:28.csv")
d3<- read_csv("twitter data/10.23/dodge_tweets_2020-10-23-11:53:34.csv")
d4<- read_csv("twitter data/10.19/dodge_tweets_2020-10-19-13:11:28.csv")
d5<- read_csv("twitter data/10.6/dodge_tweets_2020-10-06-16:16:32.RData.csv")
d6<- read_csv("twitter data/10.8/dodge_tweets_2020-10-08-12:08:31.csv")
d7<- read_csv("twitter data/10.9/dodge_tweets_2020-10-09-15:44:58.csv")

dodge <- as.data.frame(rbind(d1,d2,d3,d4,d5,d6,d7))

dodge <- clean(dodge)
d <- calc_sentimentr(dodge, polarity_dt = JR_HES)
############################################
# Ford #
############################################
f1 <- read_csv("twitter data/10.21/fordTweets_2020-10-21-13:14:14.csv")
f2 <- read_csv("twitter data/10.22/fordTweets_2020-10-22-13:59:04.csv")
f3<- read_csv("twitter data/10.23/fordTweets_2020-10-23-11:52:17.csv")
f4<- read_csv("twitter data/10.19/fordTweets_2020-10-19-13:09:18.csv")
f5<- read_csv("twitter data/10.6/fordTweets_2020-10-06-16:42:07.RData.csv")
f6<- read_csv("twitter data/10.8/fordTweets_2020-10-08-12:11:34.csv")
f7<- read_csv("twitter data/10.9/fordTweets_2020-10-09-15:46:24.csv")

ford <- as.data.frame(rbind(f1,f2,f3,f4,f5,f6,f7))
ford <- clean(ford)
f <- calc_sentimentr(ford, polarity_dt = JR_HES)

############################################
# Honda #
############################################
h1 <- read_csv("twitter data/10.21/honda_tweets_2020-10-21-13:17:14.csv")
h2<- read_csv("twitter data/10.22/honda_tweets_2020-10-22-13:57:08.csv")
h3<- read_csv("twitter data/10.23/honda_tweets_2020-10-23-11:54:08.csv")
h4<- read_csv("twitter data/10.19/honda_tweets_2020-10-19-13:12:12.csv")
h5<- read_csv("twitter data/10.6/honda_tweets_2020-10-06-16:17:45.RData.csv")
h6<- read_csv("twitter data/10.8/honda_tweets_2020-10-08-12:09:15.csv")
h7<- read_csv("twitter data/10.9/honda_tweets_2020-10-09-15:45:37.csv")

honda <- as.data.frame(rbind(h1,h2,h3,h4,h5,h6,h7))
honda <- clean(honda)
h <- calc_sentimentr(honda, polarity_dt = JR_HES)

############################################
# Toyota #
############################################
t1<- read_csv("twitter data/10.21/toyota_tweets_2020-10-21-13:14:46.csv")
t2<- read_csv("twitter data/10.22/toyota_tweets_2020-10-22-13:58:33.csv")
t3<- read_csv("twitter data/10.23/toyota_tweets_2020-10-23-11:51:44.csv")
t4 <- read_csv("twitter data/10.19/toyota_tweets_2020-10-19-13:09:55.csv")
t5<- read_csv("twitter data/10.6/toyota_tweets_2020-10-06-16:18:28.csv")
t6 <- read_csv("twitter data/10.8/toyota_tweets_2020-10-08-12:10:49.csv")
t7<- read_csv("twitter data/10.9/toyota_tweets_2020-10-09-15:43:23.csv")

toyota <- as.data.frame(rbind(t1,t2,t3,t4,t5,t6,t7))
toyota <- clean(toyota)
t <- calc_sentimentr(toyota, polarity_dt = JR_HES)

