'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 4
ImageSegmentation: Image segmentation by using UNet model
'''

# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))

# Tensor flow
import tensorflow as tf
from tensorflow.keras import models, layers
import tensorflow as tf
from tensorflow.keras.layers import Input
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import MaxPooling2D
from tensorflow.keras.layers import Dropout 
from tensorflow.keras.layers import BatchNormalization
from tensorflow.keras.layers import Conv2DTranspose
from tensorflow.keras.layers import concatenate

# For loading data
import pickle

# Module functions
from ImageUtilities import imageReadL, plotImageL, plotImageF, createImageF
from PlotUtilities import plot2Curves

'''
Parameters:
    dataSetFileName = Name of the data file
'''

dataSetFileName = "ShapesSegmentationData.pickle"

# Load dataset
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
with open(pathToDir+dataSetFileName, 'rb') as f:
     data = pickle.load(f)

trainImages, trainMasks, testImages, testMasks = data 

print(trainImages.shape, trainMasks.shape, testImages.shape, testMasks.shape)
print(trainImages[0].shape, trainMasks[0].shape, testImages[0].shape, testMasks[0].shape)

# Show a train and a test image
plotImageF(trainImages[1], figureSize = 3)
plotImageL(trainMasks[1], figureSize = 3)

plotImageF(testImages[1], figureSize = 3)
plotImageL(testMasks[1], figureSize = 3)

# Functions to create the model
# Create convolution layers
def creareConvolutionLayers(input, numFilters, kernelSize = 3):
   
    convolutionLayer = tf.keras.layers.Conv2D(filters = numFilters, kernel_size = (kernelSize, kernelSize),\
            kernel_initializer = 'he_normal', padding = 'same', activation='relu')(input)
    return convolutionLayer

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

  return dropOut, (convolutionFeatures1, convolutionFeatures2)

# Botleneck
def bottleneck(inputs):

  convolutionFeatures = creareConvolutionLayers(inputs, 256, 3)
  return convolutionFeatures

# Decoder 
def decoder(inputs, convolutionLayers, numOutputChannels):
 
  convolutionFeatures1, convolutionFeatures2 = convolutionLayers

  transpose = tf.keras.layers.Conv2DTranspose(128, kernel_size = (3,3), strides = (2,2), padding = 'same')(inputs)
  concatenate = tf.keras.layers.concatenate([transpose, convolutionFeatures2])
  dropOut = tf.keras.layers.Dropout(0.3)(concatenate)
  convolution = creareConvolutionLayers(dropOut, numFilters = 128, kernelSize=3)

  transpose = tf.keras.layers.Conv2DTranspose(64, kernel_size = (3,3), strides = (2,2), padding = 'same')(convolution)
  concatenate = tf.keras.layers.concatenate([transpose, convolutionFeatures1])
  dropOut = tf.keras.layers.Dropout(0.3)(concatenate)
  convolution = creareConvolutionLayers(dropOut, numFilters = 64, kernelSize=3)
    
  outputs = tf.keras.layers.Conv2D(filters = numOutputChannels, kernel_size = (1, 1), activation='softmax')(convolution)

  return outputs    

# Create model

# Binary segmentation
outputDimensions = 2

# Size of the images
imageSize = trainImages.shape[1]

# Input definition. One value per pixel
inputs = tf.keras.layers.Input(shape=(imageSize, imageSize,1,))
                              
# Encoder
encoderOutput, convolutionOutputs  = encoder(inputs)

# Bottleneck
bottleNeckOutput = bottleneck(encoderOutput)

# Decoder
decoderOutput = decoder(bottleNeckOutput, convolutionOutputs , numOutputChannels=outputDimensions)

# create the model
model = tf.keras.Model(inputs, decoderOutput)

# see the resulting model architecture
model.summary()

# Train the model
trainImages2 = trainImages.reshape(trainImages.shape[0],trainImages.shape[1],trainImages.shape[2],1)
trainMasks2 = trainMasks.reshape(trainMasks.shape[0],trainMasks.shape[1],trainMasks.shape[2],1)

print(trainImages2.shape)
print(trainMasks2.shape)

model.compile(optimizer=tf.keras.optimizers.Adam(), loss='sparse_categorical_crossentropy',
              metrics=['accuracy'])

history = model.fit(trainImages2, trainMasks2, epochs=10)

# Plot training
plot2Curves(history.history['loss'], history.history['accuracy'], rangeY = [-.1, 1.1])

# Save trained model
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
modelFileName = "SegmentationModel.keras"
    
model.save(pathToDir+modelFileName)

# Load trained model
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
modelFileName = "SegmentationModel.keras"

model = tf.keras.models.load_model(pathToDir+modelFileName)

# Show the model architecture
model.summary()

# Evaluation
test_loss, test_acc = model.evaluate(testImages, testMasks)
print("accuracy:", test_acc)

# Prediction
imageToPredict = 14

predictions=model.predict(testImages)

result = predictions[imageToPredict]
resultImage = createImageF(32,32)
for x in range(0, 32):
    for y in range(0,32):
        if result[y][x][0] < result[y][x][1]:
            resultImage[y][x] = 1

plotImageF(testImages[imageToPredict], figureSize = 3)
plotImageF(testMasks[imageToPredict], figureSize = 3)
plotImageF(resultImage, figureSize = 3)