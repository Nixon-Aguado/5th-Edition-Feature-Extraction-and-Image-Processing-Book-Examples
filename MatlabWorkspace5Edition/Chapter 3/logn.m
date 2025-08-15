function output= logn(image)
%Take logarithm of image
%
%  Usage: [new image] = logn(image)
%
%  Parameters: image      - array of points >0
%
%  Author: Mark S. Nixon

%get dimensions
[rows,cols]=size(image); 


%then take the logarithm
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    output(y,x)=log(image(y,x)); 
  end
end
