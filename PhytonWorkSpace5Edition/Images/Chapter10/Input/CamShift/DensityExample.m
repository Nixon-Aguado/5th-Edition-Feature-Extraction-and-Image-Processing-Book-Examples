% Compute Density Example
clear;

% Read image data
frame = imread('sequence\frame1B.bmp','bmp');

% Region of interest
region = imread('sequence\object.bmp','bmp');

% Density Estimation
filterSize = 1;

% row,column location
objectLocation = [60 100];

% Radius from the centre (rows,columns)
regionSize = [ 15 8 ];

% Compute Density
D = Density(frame, objectLocation, regionSize, filterSize);

% Display image
figure(1);
image(frame);

% Display region image
figure(2);
image(region);

% Density
figure(3);
hold on;
surf(D,'FaceColor','interp', 'EdgeColor','none', 'FaceLighting' , 'phong')
axis tight
colormap cool
view(-50,20)
camlight left
axis square
axis off
xlabel('u');
ylabel('v');
