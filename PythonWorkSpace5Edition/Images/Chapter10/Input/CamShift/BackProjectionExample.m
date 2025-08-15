% Compute Back Projection Example
clear;

% Read image data
frame = imread('sequence\frame1.bmp','bmp');

% Density estimation parameter
filterSize = .16;

% Region position
position = [60 100];

% Radius from the centre (rows,columns)
regionSize = [ 15 8 ];

% Back projection Size
backProjectionSize = round(regionSize .* 1.5);
scaleResult = [1.5 1];

% Compute initial density
q = Density(frame, position, regionSize, filterSize);

% Back project
projected = BackProjection(frame, q);

% Get scale and position 
[Crow, Ccolumn, Srow, Scolumn] = ComputeScale(projected, position, backProjectionSize,scaleResult);

% Display image
result = DrawSquare(frame,[Crow, Ccolumn],[Srow, Scolumn],0);
figure(1);
image(result);

% Density
figure(2);
hold on;
surf(q,'FaceColor','interp', 'EdgeColor','none', 'FaceLighting' , 'phong')
axis tight
colormap cool
view(-50,20)
camlight left
axis square
axis off
xlabel('u');
ylabel('v');

% Display back projected image
displayImage = frame;
[ imageRows imageColumns depth ] = size(displayImage);
m = max(max(projected));
for row = 1 : imageRows           % Image rows
    for column = 1 : imageColumns % Columns inside the image region
        val = 256*projected(row,column)/m;
        displayImage(row,column,:) = [val val val];
    end
end

result = DrawSquare(displayImage,[Crow, Ccolumn],[Srow, Scolumn],255);
figure(3);
image(result);
