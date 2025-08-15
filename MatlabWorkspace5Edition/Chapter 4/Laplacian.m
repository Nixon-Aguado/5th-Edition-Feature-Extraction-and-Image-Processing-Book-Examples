function second_order = Laplacian(image)
%New image point brightness = basic second order difference of adjacent points
%
%  Usage: [new image] = Laplacian(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
second_order(1:rows,1:cols)=0;

%then form the basic difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    second_order(y,x)= 4*image(y,x)-image(y-1,x)-image(y,x-1)-image(y,x+1)-image(y+1,x);
  end % Eq. 4.25 in two dimensions
end