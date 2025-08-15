'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 4
GenerateSegmentationColourDataSet: Generate an image set for image segmentation from tensorflow dataset
'''

# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))

# For processing images
import numpy as np 

# Tensor flow
import tensorflow as tf
import tensorflow_datasets as tfds

# For save data
import pickle

# Module functions
from ImageUtilities import plotImageRGBF

'''
Parameters:
    pathToDir = Directory to store data
    dataSetFileName = Name of the data file

    imageSize = Size of the images

    numTrainImages = Number of trains images to use
    numTestImages = Number of trains images to use
'''

pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
dataSetFileName = "PetSegmentationData.pickle"

imageSize = 128

numTrainImages = 3000
numTestImages = 300

# Flip an image
def randomFlip(inputImage, inputMask):
  if tf.random.uniform(()) > 0.5:
    inputImage = tf.image.flip_left_right(inputImage)
    inputMask = tf.image.flip_left_right(inputMask)

  return inputImage, inputMask

# Normalize an image
def normalize(inputImage, inputMask):
  inputImage = tf.cast(inputImage, tf.float32) / 255.0
  inputMask -= 1
    
  return inputImage, inputMask

# Load a resized and normalized image
def loadImageTrain(datapoint):
  inputImage = tf.image.resize(datapoint['image'], (128, 128), method='nearest')
  inputMask = tf.image.resize(datapoint['segmentation_mask'], (128, 128), method='nearest')
  inputImage, inputMask = randomFlip(inputImage, inputMask)
  inputImage, inputMask = normalize(inputImage, inputMask)
  
  return inputImage, inputMask

# Load a resized and normalized image
def loadImageTest(datapoint):
  inputImage = tf.image.resize(datapoint['image'], (128, 128), method='nearest')
  inputMask = tf.image.resize(datapoint['segmentation_mask'], (128, 128), method='nearest')
  inputImage, inputMask = normalize(inputImage, inputMask)

  return inputImage, inputMask

# Load the data set
dataset, info = tfds.load('oxford_iiit_pet:3.*.*', with_info=True)

trainData = dataset['train'].map(loadImageTrain, num_parallel_calls=tf.data.experimental.AUTOTUNE)
testData = dataset['test'].map(loadImageTest, num_parallel_calls=tf.data.experimental.AUTOTUNE)

print(info.splits['train'].num_examples)
print(info.splits['test'].num_examples)


# Show images from the dataset
# Take an image and a mask from train set
for image, mask in trainData.take(1):
    print(image.shape, mask.shape)
    plotImageRGBF(image, 3)
    plotImageRGBF(mask, 3)

# Take an image and a mask from test set
for image, mask in testData.take(1):
    print(image.shape, mask.shape)
    plotImageRGBF(image, 3)
    plotImageRGBF(mask, 3)

# Save data set
# Create array of images and mask as input to the mode
trainImages = []
trainMasks = []
testImages = []
testMasks = []

pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter4/Input/")
dataSetFileName = "AnimalSegmentationData.pickle"
    
for image, mask in trainData.take(numTrainImages):
    trainImages.append(image)
    trainMasks.append(mask)
for image, mask in testData.take(numTestImages):
    testImages.append(image)
    testMasks.append(mask)

trainImagesN = np.array(trainImages)
trainMasksN =  np.array(trainMasks)

testmagesN = np.array(testImages)
testMasksN =  np.array(testMasks)

print(trainImagesN.shape, trainMasksN.shape)
print(testmagesN.shape, testMasksN.shape)

data = (trainImagesN, trainMasksN, testmagesN, testMasksN)
with open(pathToDir+dataSetFileName, 'wb') as f:
    pickle.dump(data, f)

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