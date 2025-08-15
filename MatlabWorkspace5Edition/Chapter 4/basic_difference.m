function edge = basic_difference(image)
%New image point brightness = basic difference of adjacent points
%
%  Usage: [new image] = basic_difference(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
edge(1:rows,1:cols)=0;

%then form the basicdifference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    edge(y,x)=abs(2*image(y,x)-image(y-1,x)-image(y,x-1)); % Eq. 4.4
  end
end