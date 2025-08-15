function vertical = vertical_difference(image)
%New image point brightness = vertical difference of adjacent points
%
%  Usage: [new image] = vertical_difference(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
vertical(1:rows,1:cols)=0;

%then form the difference
for x = 1:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except borderimagesc
    vertical(y,x)=abs(image(y,x)-image(y-1,x));
  end
end