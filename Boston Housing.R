install.packages("keras")
keras::install_keras()
install.packages("kerasR")
library(kerasR)

########
# Defining the model
########

mod <- Sequential()
#Input variables equal to 13
mod$add(Dense(units = 50, input_shape = 13))

#Adding activation by a rectified linear unit
mod$add(Activation("relu"))

#Adding a dense layer with one neuron (for output)
mod$add(Dense(units = 1))

keras_compile(mod, optimizer = RMSprop(), loss = 'mse')


boston <- load_boston_housing()
X_train <- scale(boston$X_train)
Y_train <- boston$Y_train
X_test <- scale(boston$X_test)
Y_test <- boston$Y_test
