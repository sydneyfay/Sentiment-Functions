library(pROC)
library(ggplot2)

source("sentiment_functions.R")
source("analyze_sentimentr.R")
source("nb.R")

ggplot(nb_df, aes(as.factor(sentiments2), p, color = sentiments2)) +
  geom_boxplot() +geom_point() + theme_classic() + ggtitle("Naive Bayes")
m_nb <- multiclass.roc(nb_df$sentiments2 ~ nb_df$p)
m_nb
####### Jockers Rinker #########
ggplot(df, aes(category, score, color = category)) +
  geom_boxplot() +geom_point() + theme_classic() + ggtitle("Jockers Rinker")

m_new <- multiclass.roc(df$category, df$score)
m_new
#0.6438
#0.6509 with combined categories
######## Slang #########
ggplot(df2, aes(category, score, color = category)) +
  geom_boxplot() + geom_point() + theme_classic() + ggtitle("Slang")

m2 <- multiclass.roc(df2$category, df2$score)
m2
#0.5126
#Jockers Rinker is better so far

##### JR Slang #######
ggplot(df3, aes(category, score, color = category)) +
  geom_boxplot() + geom_point() + theme_classic() + ggtitle("JR & Slang")

m3 <- multiclass.roc(df3$category, df3$score)
m3
#0.5991
#Does a little worse after combining.

##### JR and Emojis ##########
ggplot(df4, aes(category, score, color = category)) +
  geom_boxplot() + geom_point() + theme_classic() + ggtitle("JR & Emojis")

m4 <- multiclass.roc(df4$category, df4$score)
m4
#0.6438

##### Emojis #######
ggplot(df5, aes(category, score, color = category)) +
  geom_boxplot() + geom_point() + theme_classic() + ggtitle("Emojis")

m5 <- multiclass.roc(df5$category, df5$score)
m5
# Not sure if this worked correctly

plot(m_new$rocs[[1]], main = 'ROC curve for Jockers Rinker Dictionary')
plot(m2$rocs[[1]], main = 'ROC curve for Slang Dictionary')
plot(m3$rocs[[1]], main = 'ROC curve for Jockers Rinker & Slang Dictionary')
plot(m4$rocs[[1]], main = 'ROC curve for Jockers Rinker and Emoji Dictionary')
plot(m5$rocs[[1]], main = 'ROC curve for Emoji Dictionary')
