function output = low_filter(image,value)
%Retain centred transform components inside circle of radius
%
%  Usage: new image = low_filter(image,number)
%
%  Parameters: image      - array of points 
%              value      - radius of filter

%get dimensions
[rows,cols]=size(image); 

%filter the transform
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    if (((y-(rows/2))^2)+((x-(cols/2))^2)-(value^2))>0 
        output(y,x)=0; %discard components outside the circle
    else
        output(y,x)=image(y,x); %and keep the ones inside
    end
  end
end
