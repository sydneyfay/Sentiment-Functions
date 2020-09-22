library(pROC)
library(ggplot2)

# create data --
#    the response is what we want to predict (e.g., actual sentiment); in this
#       example there are 3 values (1,2, and 3)
#    x is the predictor (e.g., the sentiment score)

response <- kronecker(1:3, rep(1,5))
x <- 1:15
x[4] <- 10
d <- data.frame(x = x, response = factor(response))

# plot the data -- note that the lower the 'x' value,
#    the lower the response. The prediction is almost
#    perfect, except for x = 10, which has response = 1;
#    otherwise, response 1 has x values between 1 - 5,
#    response 2 has x values between 6 - 10, etc
ggplot(d, aes(x, response, color = response)) +
  geom_point() + theme_classic()

# get the multiclass AUC, which is the average of all pairwise AUCs – this is what you should use to compare sentiment analysis methods
# Note that perfect prediction is 1; in this case, multiclass AUC is 0.94
m <- multiclass.roc(response, x)
m

# we can look at individual rocs
m$rocs[[1]]
m$rocs[[2]]
m$rocs[[3]]

# we can plot individual rocs
plot(m$rocs[[1]], main = 'ROC curve for response 1 < response 2')
