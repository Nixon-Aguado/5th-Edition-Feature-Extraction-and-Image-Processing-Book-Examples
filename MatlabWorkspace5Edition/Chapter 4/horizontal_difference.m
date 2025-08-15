function horizontal = horizontal_difference(image)
%New image point brightness = horizontal difference of adjacent points
%
%  Usage: [new image] = horizontal_difference(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
horizontal(1:rows,1:cols)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 1:rows-1 %address all rows except border
    horizontal(y,x)=abs(image(y,x-1)-image(y,x));
  end
end
