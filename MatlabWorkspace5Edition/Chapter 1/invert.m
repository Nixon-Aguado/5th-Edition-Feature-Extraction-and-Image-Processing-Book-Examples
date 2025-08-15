% Feature Extraction and Image Processing 
% Mark S. Nixon & Alberto S. Aguado
% Chapter 1: Invert an image

function inverted = invert(image)

% Subtract image point brightness from maximum
% Usage: new image = invert(old image)
% Parameters: image      - array of points 

[rows,cols]=size(image); % get dimensions 

maxi = max(max(image)); % find the maximum

% subtract image points from maximum
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    inverted(y,x)=maxi-image(y,x);
  end
end
