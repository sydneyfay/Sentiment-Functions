#MNIST

#Loading in data
mnist <- load_mnist()
X_train <- mnist$X_train
Y_train <- mnist$Y_train
X_test <- mnist$X_test
Y_test <- mnist$Y_test
dim(X_train)
#Data is 3D

#Normalizing the data to be within 0 and 1
X_train <- array(X_train, dim = c(dim(X_train)[1], prod(dim(X_train)[-1]))) / 255
X_test <- array(X_test, dim = c(dim(X_test)[1], prod(dim(X_test)[-1]))) / 255

#Converting response vector to a 10 column matrix
Y_train <- to_categorical(mnist$Y_train, 10)

### Constructing NN
# Dense layers with 512 nodes
#Pretty standard choices for a simple NN
mod <- Sequential()

mod$add(Dense(units = 512, input_shape = dim(X_train)[2]))
mod$add(LeakyReLU())
mod$add(Dropout(0.25))

mod$add(Dense(units = 512))
mod$add(LeakyReLU())
mod$add(Dropout(0.25))

mod$add(Dense(units = 512))
mod$add(LeakyReLU())
mod$add(Dropout(0.25))

mod$add(Dense(10))
mod$add(Activation("softmax"))

keras_compile(mod,  loss = 'categorical_crossentropy', optimizer = RMSprop())
keras_fit(mod, X_train, Y_train, batch_size = 32, epochs = 5, verbose = 1,
          validation_split = 0.1)
