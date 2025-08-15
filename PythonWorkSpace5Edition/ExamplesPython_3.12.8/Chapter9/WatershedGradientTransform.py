'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 9
WaterShedGradientTransform: Compute Watershed transform by considering the gradient image
'''
        
# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))
       
# Setup modules
from ImageUtilities import imageReadL, showImageL,createImageF, showImageF
from ImagePropertiesUtilities import imageMaxMin
from ConvolutionUtilities import createGaussianKernel, createSobelKernel, applyKernelMA, applyKernelF
from ImageRegionsUtilities import watherShed

# Iteration
from timeit import itertools

'''
Parameters:
    pathToDir = Input image directory
    imageName = Input image name
    suppWindow = Size of the window used to find maximum
'''
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter9/Input/")
imageName = "Logs.png"
suppWindow = 5   

# Show input image
inputImage, width, height = imageReadL(pathToDir+imageName)
showImageL(inputImage)

# Apply Sobel kernel. We use normalized magnitude in this example
sobelX, sobelY = createSobelKernel(3)
normalizeMagnitude = False
magnitude, _, _, _ = applyKernelMA(inputImage, sobelX, sobelY, normalizeMagnitude)
showImageF(magnitude)

# Apply Gaussian kernel
gaussianKernel = createGaussianKernel(10)
gaussianImage = applyKernelF(magnitude, gaussianKernel)

# Invert the image and add all pixels to the shape
shapeImage = [ ]
distanceImage = createImageF(width, height)
maxGradient, minGradient = imageMaxMin(gaussianImage)
for x,y in itertools.product(range(0, width), range(0, height)):
    distanceImage[y,x] = maxGradient - gaussianImage[y,x]
    shapeImage.append((y,x))
showImageF(distanceImage)

# Watershed of the distance image
watershed = watherShed(distanceImage, shapeImage, suppWindow)
showImageF(watershed)
