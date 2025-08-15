'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 4
ImageFeatureMaps: Show feature maps of an image
'''

# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))

# Tensor flow
import tensorflow as tf
from tensorflow.keras import models, layers
from tensorflow.keras.utils import plot_model

# In tensor flow images are numpy arrays
import numpy as np

# For load data
import pickle

# Module functions
from ImageUtilities import imageReadL, plotImageL, plotImageF

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

# Show an image from the dataset
plotImageF(trainImages[1], figureSize = 3)

#Build the model
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
history = model.fit(trainImages2,trainLabels,epochs=10, batch_size=32, verbose=1)

# Show convolution layers name
for i in range(len(model.layers)):
    layer = model.layers[i]
    if 'conv' not in layer.name:
        continue    
    print(i , layer.name , layer.output.shape)

# Show feature maps
# New model that is a subset of the layers 
newModel = tf.keras.Model(inputs=model.inputs , outputs=model.layers[2].output)

predictIndices = [2,3,4,5,6,7,8,9]
testImagestoPredic = []
for index in predictIndices:
    testImagestoPredic.append(testImages[index])

testImagestoPredic = np.array(testImagestoPredic)

testImagesPredict2=testImagestoPredic.reshape(testImagestoPredic.shape[0],testImagestoPredic.shape[1],testImagestoPredic.shape[2],1)

# Calculating features_map
features = newModel.predict(testImagesPredict2)

print (features.shape)

imageNum = 0;
for index in predictIndices:
    plotImageF(testImages[index], figureSize = 3)
    for featureMapNum in range(0,features.shape[3]):
        featureMap = features[imageNum][:, :, featureMapNum]
        plotImageF(featureMap, figureSize = 3)
    print ("-------------------------------")
    imageNum = imageNum + 1

