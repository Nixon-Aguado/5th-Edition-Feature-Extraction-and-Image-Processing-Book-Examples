function output = pad(image,template)
%Add zeroes to Gaussian template
%
%  Usage: [new image] = pad(Gaussian template)
%
%  Parameters:  image - array of points >0
%               template - 2D array of template points >0
%
%  Author: Mark S. Nixon

%get dimensions
[rows,cols]=size(image); 
[rows_t,cols_t]=size(template); 

output(1:rows,1:cols)=0;
for x = 1:cols_t %address all columns
  for y = 1:rows_t %address all rows
    output(y+floor(rows/2)-floor(rows_t/2),x+floor(cols/2)-floor(cols_t/2))=template(y,x); %copy in template
  end
end