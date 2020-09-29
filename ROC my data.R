library(pROC)
library(ggplot2)

source("sentiment_functions.R")
source("analyze_sentimentr.R")


####### Jockers Rinker #########
dfnew <- data.frame(x = factor(train$sentiment), y = s1$ave_sentiment)

ggplot(dfnew, aes(x, y, color = y)) +
  geom_point() + theme_classic()

multiclass <- multiclass.roc(y, x)
multiclass

response_new <- kronecker(-1:1, rep(1,327))
x_new <- df[,2]
View(response_new)
d_new <- data.frame(x_new, response_new = factor(response_new))
ggplot(d_new, aes(x_new, response_new, color = response_new)) +
  geom_point() + theme_classic()

m_new <- multiclass.roc(response_new, x_new)
m_new
#0.5572
#Average prediction?

######## Slang #########
response2 <- kronecker(-1:1, rep(1,327))
x2 <- df2[,2]

d2 <- data.frame(x2, response2 = factor(response2))
ggplot(d2, aes(x2, response2, color = response2)) +
  geom_point() + theme_classic()

m2 <- multiclass.roc(response2, x2)
m2
#0.5006
#Jockers Rinker is better so far

##### JR Slang #######
response3 <- kronecker(-1:1, rep(1,327))
x3 <- df3[,2]

d3 <- data.frame(x3, response3 = factor(response3))
ggplot(d3, aes(x3, response3, color = response3)) +
  geom_point() + theme_classic()

m3 <- multiclass.roc(response3, x3)
m3
#0.5417
#Does a little worse after combining.

##### JR and Emojis ##########
response4 <- kronecker(-1:1, rep(1,327))
x4 <- df4[,2]

d4 <- data.frame(x4, response4 = factor(response4))
ggplot(d4, aes(x4, response4, color = response4)) +
  geom_point() + theme_classic()

m4 <- multiclass.roc(response4, x4)
m4
#0.5572

##### Emojis #######
response5 <- kronecker(-1:1, rep(1,327))
x5 <- df5[,2]

d5 <- data.frame(x5, response5 = factor(response5))
ggplot(d5, aes(x5, response5, color = response5)) +
  geom_point() + theme_classic()

m5 <- multiclass.roc(response5, x5)
m5
# Not sure if this worked correctly

m_new$rocs[[1]]
m_new$rocs[[2]]
m_new$rocs[[3]]

plot(m_new$rocs[[1]], main = 'ROC curve for response 1 < response 2')
