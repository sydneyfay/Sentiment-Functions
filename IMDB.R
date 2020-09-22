imdb <- load_imdb(num_words = 500, maxlen = 100)

X_train <- pad_sequences(imdb$X_train[1:4000], maxlen = 100)
Y_train <- imdb$Y_train[1:4000]
X_test <- pad_sequences(imdb$X_train[4001:5736], maxlen = 100)
Y_test <- imdb$Y_train[4001:5736]

mod <- Sequential()

mod$add(Embedding(500, 32, input_length = 100, input_shape = c(100)))
mod$add(Dropout(0.25))

mod$add(Flatten())

mod$add(Dense(256))
mod$add(Dropout(0.25))
mod$add(Activation('relu'))

mod$add(Dense(1))
mod$add(Activation('sigmoid'))

keras_compile(mod, loss = 'binary_crossentropy', optimizer = RMSprop(lr = 0.00025))
keras_fit(mod, X_train, Y_train, batch_size = 32, epochs = 10, verbose = 1,
          validation_split = 0.1)