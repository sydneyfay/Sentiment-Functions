library(tm)
library(naivebayes)
library(readr)
library(SnowballC)
train <- read_csv("data/train.csv")

source("sentiment_functions.R")

train$clean <- clean(train)

#Keeping cleaned tweets
tweets <- train$clean

#Coverting to corpus
corpus <- SimpleCorpus(VectorSource(tweets))

#Document Term Matrix
DTM <- DocumentTermMatrix(corpus,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         stemming = FALSE)
                          )
inspect(DTM)

#Frequency Table of Word Counts
dtmatrix <- as.matrix(DTM)
dtmatrix <- (dtmatrix > 0)
freq <- sort(colSums(dtmatrix), decreasing = TRUE)

#Histogram
hist(freq, xlim = c(0,600), xlab = "Number of Tweets a Word Appears In")

#Coverting to DF
DTM_DF <- data.frame(as.matrix(DTM))

sentiments <- as.factor(train$sentiment)
View(sentiments)

for(i in 1: ncol(DTM_DF)) {
  DTM_DF[,i] <- as.factor(DTM_DF[,i] > 0)
}

#Training NB
nb <- naive_bayes(DTM_DF,sentiments, laplace = 1)

nb$tables$fantastic

p <- as.integer(predict(nb))
sentiments2 <- as.integer(train$sentiment)
nb_df <- data.frame(sentiments2, p)

#####################
#Training NB on test
#####################
test <- read_csv("data/test.csv")
test$clean <- clean(test)
#Keeping cleaned tweets
tweets2 <- test$clean

corpus2 <- SimpleCorpus(VectorSource(tweets2))
DTM2 <- DocumentTermMatrix(corpus2,
                          control = list(removePunctuation = TRUE,
                                         stopwords = TRUE,
                                         stemming = FALSE)
                                         #dictionary = Terms(DTM))
                          )
inspect(DTM2)
DTM2_DF <- data.frame(as.matrix(DTM2))
View(DTM2_DF)
for(i in 1: ncol(DTM2_DF)) {
  DTM2_DF[,i] <- as.factor(DTM2_DF[,i] > 0)
}

predict(nb,DTM2_DF)
predict(nb,DTM2_DF, type = "prob")

#x <- data.frame(DTM2_DF[,intersect(colnames(DTM2_DF),
#                                  colnames(DTM_DF))])






  