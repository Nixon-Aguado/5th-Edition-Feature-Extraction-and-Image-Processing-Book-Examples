'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 3
Dilation: Applies a dilation morphological filter to an image
'''

# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))

# Module functions
from ImageUtilities import imageReadL, showImageL, createImageL

# Iteration
from timeit import itertools

'''
Parameters:
    pathToDir = Input image directory
    imageName = Input image name
    kernelSize = Size of the morphological kernel
'''
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter3/Input/")
imageName = "Logs.png"
kernelSize = 5

# Read image into array
inputImage, width, height = imageReadL(pathToDir + imageName)

# Show input image
showImageL(inputImage)

# Create Kernel image
kernelCentre = int((kernelSize - 1) / 2)
kernelImage = createImageL(kernelSize, kernelSize)

# Set the pixels of a flat kernel
for x in range(0, kernelSize):
    for y in range(0, kernelSize):
        kernelImage[y,x] =  1

# Create images to store the result
outputImage = createImageL(width, height)

# Apply kernel
for x,y in itertools.product(range(0, width), range(0, height)):
   
    maxValue = 0;
    for wx,wy in itertools.product(range(0, kernelSize), range(0, kernelSize)):
        posY = y + wy - kernelCentre
        posX = x + wx - kernelCentre 
        
        if posY > -1 and posY < height and  posX > -1 and posX <  width:
            sub = float(inputImage[posY,posX]) - kernelImage[wy, wx]
           
            if sub > 0 and sub > maxValue:
                maxValue = sub 
    
    outputImage[y,x] = maxValue
            
# Show output image
showImageL(outputImage)
