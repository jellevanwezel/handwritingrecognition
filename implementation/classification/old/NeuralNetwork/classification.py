
from keras.models import Sequential
from keras.layers import Dense, Embedding
from keras.layers import LSTM


model = Sequential()
model.add(LSTM(32, input_shape=(784,)))
model.add(Activation('relu'))
model.add(Dense(10))
model.add(Activation('softmax'))

model.compile(optimizer='rmsprop',
              loss='categorical_crossentropy',
              metrics=['accuracy'])
