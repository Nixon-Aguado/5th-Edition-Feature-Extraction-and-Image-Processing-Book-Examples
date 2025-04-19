'''
Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
Chapter 10
Reprojection: Compute a projection from seven corresponding image and 3D points and re-project 
              the image to create a new view of the scene
'''
        
# Set module functions
from ImageUtilities import imageReadRGB, imageReadL, showImageRGB, createImageRGB, imageSaveRGB
from GeometricUtilities import projectionCubePoints, projectionPoints, fillImage, computeProjection, getPointColours, fillImageColours

# Math
from math import sin, cos

'''
Parameters:
    pathToDir = Input image directory
    imageName = Input image name
    maskName = Mask image name
'''
pathToDir = "../../../Images/Chapter10/Input/"
imageName = "cube1.png"
maskName = "mask1.png"

# Read image data
inputImage, width, height = imageReadRGB(pathToDir + imageName)
maskImage, width, height = imageReadL(pathToDir + maskName)
showImageRGB(inputImage)

centreX, centreY = width/2, height/2

# Corresponding points in the cube image and 3D world
pts = [[131-centreX,378-centreY],[110-centreX,188-centreY],
       [200-centreX,70-centreY],[412-centreX,100-centreY],
       [410-centreX,285-centreY],[349-centreX,418-centreY],
       [345-centreX,220-centreY]]

q = [[0,0,1],[0,1,1],
     [0,1,0],[1,1,0],
     [1,0,0],[1,0,1],
     [1,1,1]]

# Obtain the projection
p = computeProjection(pts,q)

# Get the image position of the 3D cube points
npts = 100
xy = projectionCubePoints(npts, p, centreX, centreY)

# Get the colour of the points
colours = getPointColours(xy, maskImage, inputImage)

angY = .3
angX = -.2

# Transform the q points and store in qt
for i in range(0, 20):
    qT = [ ]
    
    angY = 0.8 * (i / 20.0)
    angX = -.45 * (i/ 20.0)

    for pointNum in range(0,len(q)):
        s = [q[pointNum][0]-.5, q[pointNum][1]-.5, q[pointNum][2]-.5]
        rx = .5 + cos(angY)*s[0] + sin(angY)*s[2]
        ry = .5 + sin(angX)*sin(angY)*s[0] + cos(angX)*s[1] - sin(angX)*cos(angY)*s[2] 
        rz = .5 - cos(angX)*sin(angY)*s[0] + sin(angX)*s[1] + cos(angX)*cos(angY)*s[2] 
        
        qT.append([rx,ry,rz])
    
    tImage = createImageRGB(width, height)
    
    pt = computeProjection(pts,qT)
    
    xy = projectionPoints(q[0],q[4], q[2], npts, pt, centreX, centreY)
    fillImage([255,0,0], xy, tImage)
    
    xy = projectionPoints(q[2],q[4], q[0], npts, pt, centreX, centreY)
    fillImage([255,255,0], xy, tImage)
    
    xy = projectionPoints(q[4],q[2], q[0], npts, pt, centreX, centreY)
    fillImage([0,128,0], xy, tImage)
   
    
    #showImageRGB(tImage)  
    imageSaveRGB(tImage, "../../../Images/Chapter10/Results/SequenceCube/Ccube" + str(i) + ".png")

