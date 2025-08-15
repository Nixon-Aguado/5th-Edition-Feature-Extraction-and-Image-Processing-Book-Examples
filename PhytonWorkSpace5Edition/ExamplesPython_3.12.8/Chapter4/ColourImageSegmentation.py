'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 4
ColourImageSegmentation: Colour image segmentation by using UNet model
'''

# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))


# Tensor flow
import tensorflow as tf
import tensorflow_datasets as tfds
from tensorflow.keras import models, layers
from tensorflow.keras.layers import Input
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import MaxPooling2D
from tensorflow.keras.layers import Dropout 
from tensorflow.keras.layers import BatchNormalization
from tensorflow.keras.layers import Conv2DTranspose
from tensorflow.keras.layers import concatenate
from tensorflow.keras.losses import binary_crossentropy

# For create image array
import numpy as np 

# For loading data
import pickle

# Module functions
from ImageUtilities import imageReadRGBF, plotImageRGBF
from PlotUtilities import plot2Curves

'''
Parameters:
    pathToDir = Directory to store data
    dataSetFileName = Name of the data file
    modelFileName = Name of the file to save the trained model
'''

pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
dataSetFileName = "PetSegmentationData.pickle"
modelFileName = "ColourSegmentationModel.keras"

# Read and show image data
with open(pathToDir+dataSetFileName, 'rb') as f:
     data = pickle.load(f)

trainImages, trainMasks, testImages, testMasks = data 

print(trainImages.shape, trainMasks.shape, testImages.shape, testMasks.shape)
print(trainImages[0].shape, trainMasks[0].shape, testImages[0].shape, testMasks[0].shape)

plotImageRGBF(trainImages[0], 3)
plotImageRGBF(trainMasks[0], 3)

plotImageRGBF(testImages[0], 3)
plotImageRGBF(testMasks[0], 3)

# Functions to create the model

# Create convolution layers
def creareConvolutionLayers(input, numFilters, kernelSize = 3):
   
    convlolutionLayer = tf.keras.layers.Conv2D(filters = numFilters, kernel_size = (kernelSize, kernelSize),\
            kernel_initializer = 'he_normal', padding = 'same', activation='relu')(input)
    
    convlolutionLayer = tf.keras.layers.Conv2D(filters = numFilters, kernel_size = (kernelSize, kernelSize),\
            kernel_initializer = 'he_normal', padding = 'same', activation='relu')(convlolutionLayer)    
    return convlolutionLayer

# Encoder 
def encoder(inputs):

  # Convolution block and pool and drop
  convolutionFeatures1 = creareConvolutionLayers(inputs, numFilters = 64, kernelSize=3)
  maxPool = tf.keras.layers.MaxPooling2D(pool_size=(2,2))(convolutionFeatures1)
  dropOut = tf.keras.layers.Dropout(0.3)(maxPool)

  # Convolution block and pool and drop
  convolutionFeatures2 = creareConvolutionLayers(dropOut, numFilters = 128, kernelSize=3)
  maxPool = tf.keras.layers.MaxPooling2D(pool_size=(2,2))(convolutionFeatures2)
  dropOut = tf.keras.layers.Dropout(0.3)(maxPool)

  # Convolution block and pool and drop
  convolutionFeatures3 = creareConvolutionLayers(dropOut, numFilters = 256, kernelSize=3)
  maxPool = tf.keras.layers.MaxPooling2D(pool_size=(2,2))(convolutionFeatures3)
  dropOut = tf.keras.layers.Dropout(0.3)(maxPool)

  # Convolution block and pool and drop
  convolutionFeatures4 = creareConvolutionLayers(dropOut, numFilters = 512, kernelSize=3)
  maxPool = tf.keras.layers.MaxPooling2D(pool_size=(2,2))(convolutionFeatures4)
  dropOut = tf.keras.layers.Dropout(0.3)(maxPool)

  return dropOut, (convolutionFeatures1, convolutionFeatures2, convolutionFeatures3, convolutionFeatures4)

# Botleneck
def bottleneck(inputs):

  convolutionFeatures = creareConvolutionLayers(inputs, 1024, 3)
  return convolutionFeatures

# Decoder 
def decoder(inputs, convolutionLayers, numOutputChannels):
 
  convolutionFeatures1, convolutionFeatures2, convolutionFeatures3, convolutionFeatures4 = convolutionLayers

  transpose = tf.keras.layers.Conv2DTranspose(128, kernel_size = (3,3), strides = (2,2), padding = 'same')(inputs)
  concatenate = tf.keras.layers.concatenate([transpose, convolutionFeatures4])
  dropOut = tf.keras.layers.Dropout(0.3)(concatenate)
  convolution = creareConvolutionLayers(dropOut, numFilters = 128, kernelSize=3)

  transpose = tf.keras.layers.Conv2DTranspose(256, kernel_size = (3,3), strides = (2,2), padding = 'same')(convolution)
  concatenate = tf.keras.layers.concatenate([transpose, convolutionFeatures3])
  dropOut = tf.keras.layers.Dropout(0.3)(concatenate)
  convolution = creareConvolutionLayers(dropOut, numFilters = 256, kernelSize=3)

  transpose = tf.keras.layers.Conv2DTranspose(128, kernel_size = (3,3), strides = (2,2), padding = 'same')(convolution)
  concatenate = tf.keras.layers.concatenate([transpose, convolutionFeatures2])
  dropOut = tf.keras.layers.Dropout(0.3)(concatenate)
  convolution = creareConvolutionLayers(dropOut, numFilters = 128, kernelSize=3)

  transpose = tf.keras.layers.Conv2DTranspose(64, kernel_size = (3,3), strides = (2,2), padding = 'same')(convolution)
  concatenate = tf.keras.layers.concatenate([transpose, convolutionFeatures1])
  dropOut = tf.keras.layers.Dropout(0.3)(concatenate)
  convolution = creareConvolutionLayers(dropOut, numFilters = 64, kernelSize=3)

  outputs = tf.keras.layers.Conv2D(numOutputChannels, kernel_size = (1, 1), activation='softmax')(convolution)

  return outputs

# Create model

# Three classes segmentation
outputDimensions = 3

# Size of the images
imageSize = trainImages.shape[1]

# Input definition. Thhree values per pixel
inputs = tf.keras.layers.Input(shape=(imageSize, imageSize,3,))

# Encoder
encoderOutput, convolutionLayers = encoder(inputs)

# Bottleneck
bottleNeckOutput = bottleneck(encoderOutput)

# Decoder
decoderOutput = decoder(bottleNeckOutput, convolutionLayers, numOutputChannels=outputDimensions)

# create the model
model = tf.keras.Model(inputs, decoderOutput)

# see the resulting model architecture
model.summary()

# Train the model

print(trainImages.shape)
print(trainMasks.shape)
print(testImages.shape)
print(testMasks.shape)

model.compile(optimizer=tf.keras.optimizers.Adam(), loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])
# configure the training parameters and train the model
history = model.fit(trainImages, trainMasks, epochs=10)

# Plot training
plot2Curves(history.history['loss'], history.history['accuracy'], rangeY = [-.1, 1.1])

# Save model
model.save(pathToDir+modelFileName)

# Load model
model = tf.keras.models.load_model(pathToDir+modelFileName)

# Show the model architecture
model.summary()

# Evaluation
test_loss, test_acc = model.evaluate(testImages, testMasks)
print("accuracy:", test_acc)

# Prediction
imageToPredict = 27

predictions=model.predict(testImages)

print(predictions[imageToPredict][3][3])

plotImageRGBF(testImages[imageToPredict], 3)
plotImageRGBF(predictions[imageToPredict], 3)

# Predict for new image
# Read image
imageName = "Squirrel.png"
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
inputImage, width, height  = imageReadRGBF(pathToDir + imageName)

# Prediction
testmagesN = np.array( [inputImage])
predictions=model.predict(testmagesN)

# Show results
plotImageRGBF(inputImage, 3)
plotImageRGBF(predictions[0], 3)