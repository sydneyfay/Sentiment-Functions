library(rtweet)

consumer_key <- "9GnGOWP2vtFLvuM1sC0NePNUG"
consumer_secret <- "x1AQHMngJfr9pkdC7SrJ7LkFeF8tYHmzgiSa1hjlyQVh40e3ZV"
access_token <- "3884085317-Jfrcpgg0zoxEDdbCWacSGBp4NXlwlF5AMjG1vaV"
access_secret <- "j5ODlWZx51TDmNS0ME5X1eE4OTYpTAhsSsiPyXlofwrOG"
token <- create_token(app = "Sydney Calvert Sentiment", consumer_key, consumer_secret,
                      access_token, access_secret)
x <- rate_limits()

ford <- search_tweets(q = "@Ford", n = 3600, type = "recent", lang = "en")
t <- Sys.time()
t <- gsub(' ','-',t)
savedTweets <- paste0('fordTweets_',t)
save_as_csv(ford, savedTweets)
#save(ford, file = savedTweets)

toyota <- search_tweets(q = "@Toyota", n =3600, type = "recent", lang = "en")
t <- Sys.time()
t <- gsub(' ','-',t)
savedTweets <- paste0('toyota_tweets_',t)
save_as_csv(toyota, savedTweets)
#save(toyota, file = savedTweets)

#rav4 <- search_tweets(q = "rav4", n = 1000, type = "recent", lang = "en")
#t <- Sys.time()
#t <- gsub(' ','-',t)
#savedTweets <- paste0('rav4_tweets_',t,'.RData')
#save(rav4, file = savedTweets)

#camry <- search_tweets(q = "camry", n = 1000, type = "recent", lang = "en")
#t <- Sys.time()
#t <- gsub(' ','-',t)
#savedTweets <- paste0('camry_tweets_',t,'.RData')
#save(camry, file = savedTweets)

#corolla = search_tweets(q = "corolla", n =1000, type = "recent", lang = "en")
#t <- Sys.time()
#t <- gsub(' ','-',t)
#savedTweets <- paste0('corolla_tweets_',t,'.RData')
#save(corolla, file = savedTweets)

chevrolet <- search_tweets(q = "@chevrolet", n =3600, type = "recent", lang = "en")
t <- Sys.time()
t <- gsub(' ','-',t)
savedTweets <- paste0('chevrolet_tweets_',t)
save_as_csv(chevrolet, savedTweets)
#save(chevrolet, file = savedTweets)

#silverado <- search_tweets(q = "silverado", n =1000, type = "recent", lang = "en")
#t <- Sys.time()
#t <- gsub(' ','-',t)
#savedTweets <- paste0('silverado_tweets_',t,'.RData')
#save(silverado, file = savedTweets)


dodge <- search_tweets(q = "@Dodge", n =3600, type = "recent", lang = "en")
t <- Sys.time()
t <- gsub(' ','-',t)
savedTweets <- paste0('dodge_tweets_',t)
save_as_csv(dodge, savedTweets)
#save(dodge, file = savedTweets)

honda <- search_tweets(q = "@Honda", n =3600, type = "recent", lang = "en")
t <- Sys.time()
t <- gsub(' ','-',t)
savedTweets <- paste0('honda_tweets_',t)
save_as_csv(honda, savedTweets)
#save(honda, file = savedTweets)

