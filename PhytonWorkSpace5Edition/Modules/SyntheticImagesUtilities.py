'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
SyntheticImagesUtilities: Helper module to create synthetic images  
'''

# Module functions
from ImageUtilities import createImageL, createImageF
from ConvolutionUtilities import createGaussianKernel, applyKernelF

# Iteration and Maths
from math import sqrt, sin ,cos, radians 
from random import randint,uniform


# Function to get initial and final points in a line/curve
def twoPoints(lineLength, borderLengthTop, borderLengthLeft, imageSize):
    
    # Initial point on top
    p1 = [randint(borderLengthTop, imageSize - lineLength - borderLengthTop), randint(borderLengthLeft, imageSize - borderLengthLeft - 1)]
    if randint(0, 1) == 1:
        p1[1] = imageSize - p1[1]
    
    # Horizontal displacement for second point
    p2 = [0,0]
    deltaX = randint(0, int(lineLength / 2))    
    if randint(0, 1) == 1:
        deltaX =  -deltaX
    
    p2[1] = p1[1] + deltaX
    
    if p2[1] < borderLengthLeft:
        p2[1] = borderLengthLeft
    if p2[1] >= imageSize - borderLengthLeft:
        p2[1] = imageSize - borderLengthLeft - 1
    
    deltaY = p2[1] - p1[1]
    p2[0] = p1[0] + int(sqrt(lineLength * lineLength - deltaY * deltaY))
        
    return p1, p2
    
# Function to blur and add noise an image
def addBlurandNoise(image, imageSize, noiseKernelSize):
    outputImage = createImageF(imageSize, imageSize)

    # Filter Kernel
    noiseKernel = createGaussianKernel(noiseKernelSize)

    if noiseKernelSize > 2:
        noiseKernel2 = createGaussianKernel(noiseKernelSize-1) 
    else:
        noiseKernel2 = createGaussianKernel(1) 

    for x in range(0, imageSize):
        for y in range(0,imageSize):
             outputImage[x, y] = image[x, y]
             if randint(0, 2) == 1:
                outputImage[x, y] = uniform(0.5, 1)
                     
    outputImage = applyKernelF(outputImage, noiseKernel)

    for x in range(0, imageSize):
        for y in range(0,imageSize):
             if randint(0, 4) == 1:
                outputImage[x, y] = uniform(0.2, 1)
    
    outputImage = applyKernelF(outputImage, noiseKernel2)

    return outputImage

# Function to trace a line in an image
def traceLine(p1, p2, image):
    # Trace
    pointList = [ p1, p2 ]
    while len(pointList) != 0:
        pa = pointList.pop(0);
        pb = pointList.pop(0);

        for dx in range(-1, 1):
            for dy in range(-1, 1):
                image[pa[0]+dy,pa[1]+dx] = 1 
                image[pb[0]+dy,pb[1]+dx] = 1

        distance = sqrt((pa[0]-pb[0]) * (pa[0]-pb[0]) + (pa[1]-pb[1]) * (pa[1]-pb[1]))

        if distance > 1.5:
            pm = [int(pa[0] + (pb[0]-pa[0])/2), int(pa[1] + (pb[1]-pa[1])/2)]
            pointList.append(pa)
            pointList.append(pm)
            pointList.append(pm)
            pointList.append(pb)
            
def traceLineAndMask(p1, p2, image, maksImage):
    # Trace
    pointList = [ p1, p2 ]
    while len(pointList) != 0:
        pa = pointList.pop(0);
        pb = pointList.pop(0);

        for dx in range(-1, 1):
            for dy in range(-1, 1):
                image[pa[0]+dy,pa[1]+dx] = 1 
                image[pb[0]+dy,pb[1]+dx] = 1
                maksImage[pa[0]+dy,pa[1]+dx] = 1 
                maksImage[pb[0]+dy,pb[1]+dx] = 1

        distance = sqrt((pa[0]-pb[0]) * (pa[0]-pb[0]) + (pa[1]-pb[1]) * (pa[1]-pb[1]))

        if distance > 1.5:
            pm = [int(pa[0] + (pb[0]-pa[0])/2), int(pa[1] + (pb[1]-pa[1])/2)]
            pointList.append(pa)
            pointList.append(pm)
            pointList.append(pm)
            pointList.append(pb)

# Function to create syntethic line images
def createLineImages(numTrainImages, numTestImages, lineLengthMin, lineLengthMax, imageSize, noiseKernelSize):
    # List of outout images
    outputTrainImages = []
    outputTestImages = []

    # A safe region
    borderLengthTop = 3;
    borderLengthLeft = 4;

    for imageNum in range(0, numTrainImages + numTestImages):
        # Create images to store the result
        image = createImageF(imageSize, imageSize)
        outputImage = createImageF(imageSize, imageSize)

        # Rnadom lenght
        lineLength = randint(lineLengthMin, lineLengthMax)

         # Inital and final points 
        p1, p2 = twoPoints(lineLength, borderLengthTop, borderLengthLeft, imageSize)

        # Trace line
        traceLine(p1, p2, image);  
        outputImage = addBlurandNoise(image, imageSize, noiseKernelSize)

        if imageNum < numTrainImages:
            outputTrainImages.append(outputImage)
        else:
            outputTestImages.append(outputImage)

    return outputTrainImages, outputTestImages

# Function to create syntethic curve images
def createCurveImages(numTrainImages, numTestImages, curveLengthMin, curveLengthMax, imageSize, noiseKernelSize):
    # List of outout images
    outputTrainImages = []
    outputTestImages = []

    # A safe region
    borderLengthTop = 3;
    borderLengthLeft = 10;
    
    for imageNum in range(0, numTrainImages + numTestImages):
        # Create images to store the result
        image = createImageF(imageSize, imageSize)
    
        # Random lenght
        curveLength = randint(curveLengthMin, curveLengthMax)

        # Inital and final points 
        p1, p2 = twoPoints(curveLength, borderLengthTop, borderLengthLeft, imageSize)
        
        # Trace
        pm = [int(p1[0] + (p2[0]-p1[0])/2), int(p1[1] + (p2[1]-p1[1])/2)]
        ps = [int(p1[0] * uniform(.8,1.2) + (pm[0]-p1[0])/2), int(p1[1] * uniform(.8,1.2) + (pm[1]-p1[1])/2)]
        pt = [int(pm[0] * uniform(.8,1.2) + (p2[0]-pm[0])/2), int(pm[1] * uniform(.8,1.2) + (p2[1]-pm[1])/2)]

        ps[1] = ps[1] + int(curveLength * uniform(.4,.5))
        pt[1] = pt[1] - int(curveLength * uniform(.4,.5))

        if ps[1] >  imageSize -2:
            ps[1] = imageSize -2
        if pt[1] < 2:
            pt[1] = 2

         # Trace line
        traceLine(p1, ps,image);
        traceLine(ps, pm,image);
        traceLine(pm, pt,image);
        traceLine(pt, p2,image);
        
        outputImage = addBlurandNoise(image, imageSize, noiseKernelSize)
        
        if imageNum < numTrainImages:
            outputTrainImages.append(outputImage)
        else:
            outputTestImages.append(outputImage)

    return outputTrainImages, outputTestImages

# Function to create syntethic circle images
def createCircleImages(numTrainImages, numTestImages, radiousMin, radiousMax, imageSize, noiseKernelSize):
    # List of outout images
    outputTrainImages = []
    outputTestImages = []
    
    # A safe region
    borderLength = 3;
    
    for imageNum in range(0, numTrainImages + numTestImages):
        # Create images to store the result
        image = createImageF(imageSize, imageSize)
        outputImage = createImageF(imageSize, imageSize)
    
       # Rnadom lenght
        radious = randint(radiousMin, radiousMax)

        # Centre 
        pc = [randint(borderLength + radious, imageSize- borderLength - radious), randint(borderLength + radious, imageSize - borderLength- radious)]

        # Trace
        u = radious * uniform(.8,1.2)
        p1 = [pc[0] + int(u*cos(0)), pc[1] + int(u*sin(0))]
        for angle in range(10, 360, 10):
            angleRadians = radians(angle)
            u = radious * uniform(.8,1.2)
            p2 = [pc[0] + int(u*cos(angleRadians)), pc[1] + int(u*sin(angleRadians))]
            traceLine(p1, p2, image);
            p1 = p2
    
        outputImage = addBlurandNoise(image, imageSize, noiseKernelSize)
        
        if imageNum < numTrainImages:
            outputTrainImages.append(outputImage)
        else:
            outputTestImages.append(outputImage)

    return outputTrainImages, outputTestImages


def createLineImagesAndMasks(numTrainImages, numTestImages, lineLengthMin, lineLengthMax, imageSize, noiseKernelSize):
    # List of outout images
    outputTrainImages = []
    outputTestImages = []
    outputTrainMasks = []
    outputTestMasks = []

    # A safe region
    borderLengthTop = 3;
    borderLengthLeft = 4;

    for imageNum in range(0, numTrainImages + numTestImages):
        # Create images to store the result
        image = createImageF(imageSize, imageSize)
        maksImage = createImageL(imageSize, imageSize)
        outputImage = createImageF(imageSize, imageSize)

        # Rnadom lenght
        lineLength = randint(lineLengthMin, lineLengthMax)

         # Inital and final points 
        p1, p2 = twoPoints(lineLength, borderLengthTop, borderLengthLeft, imageSize)

        # Trace line
        traceLineAndMask(p1, p2, image, maksImage);  
        outputImage = addBlurandNoise(image, imageSize, noiseKernelSize)

        if imageNum < numTrainImages:
            outputTrainImages.append(outputImage)
            outputTrainMasks.append(maksImage)
        else:
            outputTestImages.append(outputImage)
            outputTestMasks.append(maksImage)

    return outputTrainImages, outputTestImages, outputTrainMasks, outputTestMasks
    
    
def createCurveImagesAndMasks(numTrainImages, numTestImages, curveLengthMin, curveLengthMax, imageSize, noiseKernelSize):
    # List of outout images
    outputTrainImages = []
    outputTestImages = []
    outputTrainMasks = []
    outputTestMasks = []

    # A safe region
    borderLengthTop = 3;
    borderLengthLeft = 10;
    
    for imageNum in range(0, numTrainImages + numTestImages):
        # Create images to store the result
        image = createImageF(imageSize, imageSize)
        maksImage = createImageL(imageSize, imageSize)
        outputImage = createImageF(imageSize, imageSize)
    
        # Random lenght
        curveLength = randint(curveLengthMin, curveLengthMax)

        # Inital and final points 
        p1, p2 = twoPoints(curveLength, borderLengthTop, borderLengthLeft, imageSize)
        
        # Trace
        pm = [int(p1[0] + (p2[0]-p1[0])/2), int(p1[1] + (p2[1]-p1[1])/2)]
        ps = [int(p1[0] * uniform(.8,1.2) + (pm[0]-p1[0])/2), int(p1[1] * uniform(.8,1.2) + (pm[1]-p1[1])/2)]
        pt = [int(pm[0] * uniform(.8,1.2) + (p2[0]-pm[0])/2), int(pm[1] * uniform(.8,1.2) + (p2[1]-pm[1])/2)]

        ps[1] = ps[1] + int(curveLength * uniform(.4,.5))
        pt[1] = pt[1] - int(curveLength * uniform(.4,.5))

        if ps[1] >  imageSize -2:
            ps[1] = imageSize -2
        if pt[1] < 2:
            pt[1] = 2

         # Trace line
        traceLineAndMask(p1, ps,image,maksImage);
        traceLineAndMask(ps, pm,image,maksImage);
        traceLineAndMask(pm, pt,image,maksImage);
        traceLineAndMask(pt, p2,image,maksImage);
        
        outputImage = addBlurandNoise(image, imageSize, noiseKernelSize)
        
        if imageNum < numTrainImages:
            outputTrainImages.append(outputImage)
            outputTrainMasks.append(maksImage)
        else:
            outputTestImages.append(outputImage)
            outputTestMasks.append(maksImage)

    return outputTrainImages, outputTestImages, outputTrainMasks, outputTestMasks
    
def createCircleImagesAndMasks(numTrainImages, numTestImages, radiousMin, radiousMax, imageSize, noiseKernelSize):
    # List of outout images
    outputTrainImages = []
    outputTestImages = []
    outputTrainMasks = []
    outputTestMasks = []
    
    # A safe region
    borderLength = 3;
    
    for imageNum in range(0, numTrainImages + numTestImages):
        # Create images to store the result
        image = createImageF(imageSize, imageSize)
        maksImage = createImageL(imageSize, imageSize)
        outputImage = createImageF(imageSize, imageSize)
    
        # Rnadom lenght
        radious = randint(radiousMin, radiousMax)

        # Centre 
        pc = [randint(borderLength + radious, imageSize- borderLength - radious), randint(borderLength + radious, imageSize - borderLength- radious)]

        # Trace
        u = radious * uniform(.8,1.2)
        p1 = [pc[0] + int(u*cos(0)), pc[1] + int(u*sin(0))]
        for angle in range(10, 360, 10):
            angleRadians = radians(angle)
            u = radious * uniform(.8,1.2)
            p2 = [pc[0] + int(u*cos(angleRadians)), pc[1] + int(u*sin(angleRadians))]
            traceLineAndMask(p1, p2, image, maksImage);
            p1 = p2
    
        outputImage = addBlurandNoise(image, imageSize, noiseKernelSize)
        
        if imageNum < numTrainImages:
            outputTrainImages.append(outputImage)
            outputTrainMasks.append(maksImage)
        else:
            outputTestImages.append(outputImage)
            outputTestMasks.append(maksImage)

    return outputTrainImages, outputTestImages, outputTrainMasks, outputTestMasks