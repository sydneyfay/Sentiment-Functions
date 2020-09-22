install.packages("twitteR")
library(twitteR)

consumer_key <- "9GnGOWP2vtFLvuM1sC0NePNUG"
consumer_secret <- "x1AQHMngJfr9pkdC7SrJ7LkFeF8tYHmzgiSa1hjlyQVh40e3ZV"
access_token <- "3884085317-Jfrcpgg0zoxEDdbCWacSGBp4NXlwlF5AMjG1vaV"
access_secret <- "j5ODlWZx51TDmNS0ME5X1eE4OTYpTAhsSsiPyXlofwrOG"

setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret)

ford = searchTwitter('@Ford', n=50)
head(ford)

toyota = searchTwitter('@Toyota', n = 50)
head(toyota)
rav4 = searchTwitter('rav4', n = 50)
head(rav4)
camry = searchTwitter('camry', n = 50)
head(camry)
corolla = searchTwitter('corolla', n =50)
head(corolla)

chevrolet = searchTwitter('@Chevrolet', n = 50)
head(chevrolet)
silverado = searchTwitter('silverado' , n = 50)
head(silverado)

dodge = searchTwitter('@Dodge', n = 50)
head(dodge)

honda = searchTwitter('@Honda', n = 50)
head(honda)
