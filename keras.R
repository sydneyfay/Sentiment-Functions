library(dplyr)
library(ggplot2)
library(purrr)
library(readr)
library(keras)
library(tensorflow)

mnist <- dataset_mnist()
mnist$train$x <- mnist$train$x/255
mnist$test$x <- mnist$test$x/255

model <- keras_model_sequential() %>% 
  layer_flatten(input_shape = c(28, 28)) %>% 
  layer_dense(units = 128, activation = "relu") %>% 
  layer_dropout(0.2) %>% 
  layer_dense(10, activation = "softmax")
summary(model)

model %>% 
  compile(
    loss = "sparse_categorical_crossentropy",
    optimizer = "adam",
    metrics = "accuracy"
  )
model %>% 
  fit(
    x = mnist$train$x, y = mnist$train$y,
    epochs = 5,
    validation_split = 0.3,
    verbose = 2
  )

#Making predictions with the compiled model
predictions <- predict(model, mnist$test$x)
y <- head(predictions, 2)
round(y, 2)

mnist$test$y[1:2]
#Determining the model accuracy
#Accuracy-loss?
model %>% 
  evaluate(mnist$test$x, mnist$test$y, verbose = 0)

save_model_tf(object = model, filepath = "model")

reloaded_model <- load_model_tf("model")
all.equal(predict(model, mnist$test$x), predict(reloaded_model, mnist$test$x))


##########################################
movie <- read_csv("~/Downloads/archive/movie_review.csv")
movie %>% count(tag)
# There are about half positive and half negative reviews
movie$text[1]

training_id <- sample.int(nrow(movie), size = nrow(movie)*0.8)
training <- movie[training_id,]
testing <- movie[-training_id,]

movie$text %>% 
  strsplit(" ") %>% 
  sapply(length) %>% 
  summary()

#Define Text Vectorization layer 
num_words <- 10000
max_length <- 50
text_vectorization <- layer_text_vectorization(
  max_tokens = num_words, 
  output_sequence_length = max_length, 
)

text_vectorization %>% 
  adapt(movie$text)

get_vocabulary(text_vectorization)
text_vectorization(matrix(movie$text[1], ncol = 1))

# Starting to layer the model
input <- layer_input(shape = c(1), dtype = "string")

output <- input %>% 
  text_vectorization() %>% 
  layer_embedding(input_dim = num_words + 1, output_dim = 16) %>%
  layer_global_average_pooling_1d() %>%
  layer_dense(units = 16, activation = "relu") %>%
  layer_dropout(0.5) %>% 
  layer_dense(units = 1, activation = "sigmoid")
model <- keras_model(input, output)

#Needed for training
model %>% compile(
  optimizer = 'adam',
  loss = 'binary_crossentropy',
  metrics = list('accuracy')
)

history <- model %>% fit(
  training$text,
  as.numeric(training$tag == "pos"),
  epochs = 10,
  batch_size = 512,
  validation_split = 0.2,
  verbose=2
)

#Results of the model 
results <- model %>% evaluate(testing$text, as.numeric(testing$tag == "pos"), verbose = 0)
results

plot(history)
