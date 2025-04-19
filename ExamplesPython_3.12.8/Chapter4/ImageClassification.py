'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 4
ImageClassification: Classify an image by using deep learning
'''

# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))

# Tensor flow
import tensorflow as tf
from tensorflow.keras import models, layers

# For loading data
import pickle

# Module functions
from ImageUtilities import imageReadL, plotImageL, plotImageF
from PlotUtilities import plot2Curves

'''
Parameters:
    dataSetFileName = Name of the data file
'''

dataSetFileName = "ShapesClassificationData.pickle"

# Load dataset
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
with open(pathToDir+dataSetFileName, 'rb') as f:
     data = pickle.load(f)

trainImages, trainLabels, testImages, testLabels = data 

print(trainImages.shape, trainLabels.shape, testImages.shape, testLabels.shape)
print(trainLabels.shape[0])

trainLabels= tf.keras.utils.to_categorical(trainLabels)
testLabels= tf.keras.utils.to_categorical(testLabels)

# Number of classes
print(trainLabels.shape[1])

# Show an image
plotImageF(trainImages[4], figureSize = 3)

# Build the model
imageSize = trainImages.shape[1]

model = tf.keras.Sequential()
model.add(tf.keras.Input(shape=(imageSize, imageSize, 1)))
model.add(layers.Conv2D(3,(3,3),activation='relu')) 
model.add(layers.MaxPooling2D(pool_size=(2,2)))
model.add(layers.Conv2D(2,(3,3),activation='relu'))
model.add(layers.MaxPooling2D(pool_size=(2,2)))
model.add(layers.Flatten())
model.add(layers.Dense(128, activation='relu'))
model.add(layers.Dense(100, activation='relu'))
model.add(layers.Dense(80, activation='relu'))
model.add(layers.Dense(trainLabels.shape[1], activation='softmax'))

model.summary()

# Train the model
trainImages2=trainImages.reshape(trainImages.shape[0],trainImages.shape[1],trainImages.shape[2],1)

model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])
history = model.fit(trainImages2,trainLabels,epochs=15, batch_size=32, verbose=1)

# Plot training
plot2Curves(history.history['loss'], history.history['accuracy'], rangeY = [-.1, 1.1])

# Evaluation
testImages2=testImages.reshape(testImages.shape[0],testImages.shape[1],testImages.shape[2],1)

test_loss, test_acc = model.evaluate(testImages2, testLabels)
print("accuracy:", test_acc)

#Prediction
imageToPredict = 14

predictions=model.predict(testImages2)

print("Prediction  : %s" % [ "{:0.1f}".format(x) for x in predictions[imageToPredict] ])
print("Actual label: %s" % (testLabels[imageToPredict]))

plotImageF(testImages[imageToPredict], figureSize = 3)