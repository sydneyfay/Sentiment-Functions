library(dplyr)
library(ggplot2)
library(purrr)
library(readr)
library(keras)
library(tensorflow)
library(car)

train <- read_csv("data/train.csv")

training_id <- sample.int(nrow(train), size = nrow(train)*0.8)
training <- train[training_id,]
testing <- train[-training_id,]

train$text %>% 
  strsplit(" ") %>% 
  sapply(length) %>% 
  summary()

#Define Text Vectorization layer 
num_words <- 1000
max_length <- 300
text_vectorization <- layer_text_vectorization(
  max_tokens = num_words, 
  output_sequence_length = NULL, 
)
text_vectorization %>% 
  adapt(train$text)

get_vocabulary(text_vectorization)

input <- layer_input(shape = c(1), dtype = "string")

output <- input %>% 
  text_vectorization() %>% 
  layer_embedding(input_dim = num_words + 1, output_dim = 50) %>%
  layer_global_average_pooling_1d() %>%
  layer_dense(units = 50, activation = "relu") %>%
  layer_dropout(0.2) %>% 
  layer_dense(units = 5, activation = "softmax")
model <- keras_model(input, output)

#Needed for training
model %>% compile(
  optimizer = 'adam',
  loss = 'sparse_categorical_crossentropy',
  metrics = list('accuracy')
)

sents <- as.array(training$sentiment-1)
history <- model %>% fit(
  training$text,
  sents,
  epochs = 10,
  batch_size = NULL,
  validation_split = 0.2,
  verbose=1
)
model %>% fit(
  training$text,
  sents,
  epochs = 10,
  batch_size = NULL,
  validation_split = 0.2,
  verbose=1
)
predict_classes(model, training$text)
