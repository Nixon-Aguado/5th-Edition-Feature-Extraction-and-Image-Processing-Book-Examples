function output = high_filter(image,radius)
%Retain centred transform components outside circle of radius
%
%  Usage: new image = high_filter(image,number)
%
%  Parameters: image      - array of points 
%              radius      - radius of filter

%get dimensions
[rows,cols]=size(image); 

%filter the transform
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    if (((y-(rows/2)-1)^2)+((x-(cols/2))^2-1)-(radius^2))>0 
        output(y,x)=image(y,x);
    else
        output(y,x)=0;
    end
  end
end
