% Feature Extraction and Image Processing 
% Mark S. Nixon & Alberto S. Aguado
% Chapter 1: Add brightnerss to an image

function added = add(image,value)

%New image point brightness = old brightness + value
%  Usage: [new image] = add(image,number)
%  Parameters: image      - array of points 
%              value      - added brightness

%get dimensions
[rows,cols]=size(image); 

%add value to image points
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    added(y,x)=image(y,x)+value;
    %keep brightness within display limits
    if added(y,x)>255 
        added(y,x)=255
    end;
    if added(y,x)<0 
        added(y,x)=0
    end;
  end
end
