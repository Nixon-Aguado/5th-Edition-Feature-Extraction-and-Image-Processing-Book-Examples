'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 2
FourierShiftedImage: Compute the Fourier transform of a shifted image
'''

# Set up modules path 
# It can also be set in sys variables
import os
import sys
sys.path.append(os.path.join(os.path.dirname(__file__), "../../Modules"))

# Set module functions
from ImageUtilities import imageReadL, showImageL, createImageL, showImageF
from ImageOperatorsUtilities import imageLogF
from FourierUtilities import computePowerandPhase

# Iteration
from timeit import itertools

'''
Parameters:
    pathToDir = Input image directory
    imageName = Input image name
'''
pathToDir = os.path.join(os.path.dirname(__file__), "../../Images/Chapter2/Input/")
imageName = "Dandelion.png"

# Read image into array
inputImage, width, height  = imageReadL(pathToDir + imageName)

# Shift the image
shiftDistance =  int(width / 3);
shiftImage = createImageL(width, height)

for x,y in itertools.product(range(0, width), range(0, height)):
    xShift = (x - shiftDistance) % width 
    shiftImage[y][x] = inputImage[y][xShift]

# Show images
showImageL(inputImage)
showImageL(shiftImage)

# Compute power and phase 
powerImage, phaseImage  = computePowerandPhase(inputImage)
powerShiftImage, phaseShiftImage = computePowerandPhase(shiftImage)
 
# Show power
powerImageLog = imageLogF(powerImage)
powerShiftImageLog = imageLogF(powerShiftImage)
showImageF(powerImageLog)
showImageF(powerShiftImageLog)

# show phase
showImageF(phaseImage)
showImageF(phaseShiftImage)

