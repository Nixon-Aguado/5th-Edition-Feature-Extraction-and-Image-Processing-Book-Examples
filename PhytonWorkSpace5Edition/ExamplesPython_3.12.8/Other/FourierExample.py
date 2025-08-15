'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
Chapter 7: Compute elliptic Fourier descriptors 
'''

# Image utility functions
from ImageSupport import createImageF,imageSaveF        
# Edges into segments
from ObjectDescriptionUtilities import shapeMaxMin,                   \
                                findLongestCentredSegmentinImage, showShapeinImage, getShapeinImage
# Plot functions
from PlotSupport import plotCurve
# Math functions
from math import pi, sin, cos

'''
Parameters:
    pathToDir = Input image directory
    imageName = Input image name
    cannyKernelSize = Canny kernel size
    upperT = Upper threshold
    lowerT = Lower threshold
    numDescriptors = Number of descriptors
'''
pathToDir = "../../../Images/Chapter7/Input/"
imageName = "f14x200.png"
cannyKernelSize = 3
upperT = 0.3
lowerT = 0.05
numDescriptors = 51

# Obtain a shape from the input image and show
centre, shape, width, height = findLongestCentredSegmentinImage(pathToDir + imageName,   \
                                                         cannyKernelSize, upperT, lowerT)
showShapeinImage(shape, centre, width, height)

# Add one coefficient to include the shape position 
numEdges = len(shape[0])
if numDescriptors == 0:  numDescriptors = 1 + numEdges /2
else:                    numDescriptors += 1
    
# Display functions for x and y with domain values form 0 to 2pi
x, y = shape[1,:], shape[0,:] 
maxVal, minVal = shapeMaxMin(shape)

# Compute coefficients. The vector a contains ax,ay and b bx,by
t = 2.0 * pi / numEdges
a = createImageF(numDescriptors, 2)
b = createImageF(numDescriptors, 2)
for k in range(1, numDescriptors):
    for p in range(0, numEdges):
        a[0, k] += x[p] * cos(k*t*p)
        a[1, k] += y[p] * cos(k*t*p)
        b[0, k] += x[p] * sin(k*t*p)
        b[1, k] += y[p] * sin(k*t*p)

for k in range(1, numDescriptors):     
    a[0, k] *= (2.0/numEdges)
    a[1, k] *= (2.0/numEdges)
    b[0, k] *= (2.0/numEdges)
    b[1, k] *= (2.0/numEdges)


# Draw shape from coefficients
for i in range(numDescriptors,0,-2):
    shapeReconst = createImageF(numEdges, 2)
    for k in range(1, i):
        for p in range(0, numEdges):
            shapeReconst[0, p] += a[1,k] * cos(k*t*p) + b[1,k] * sin(k*t*p)
            shapeReconst[1, p] += a[0,k] * cos(k*t*p) + b[0,k] * sin(k*t*p)
    image = getShapeinImage(shapeReconst, centre, width, height)
    imageSaveF(image, "../../../Images/Chapter7/Results/SequenceShapes/plane" + str(i) + ".png")

