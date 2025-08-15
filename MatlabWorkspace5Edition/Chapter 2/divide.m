%Split an image into its bit planes
%
%  Usage: new image = divide(image,number)
%
%  Parameters: image      - array of points 
%              value      - radius of filter

image=imread('filmsmall','png');

%get dimensions
[rows,cols]=size(image); 

%filter the transform
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
      rem=double(image(y,x));
      slice1(y,x)=round(round(rem/2)-rem/2);
      rem=round(rem/2);
      slice2(y,x)=round(round(rem/2)-rem/2);
      rem=round(rem/2);
      slice3(y,x)=round(round(rem/2)-rem/2);
      rem=round(rem/2);
      slice4(y,x)=round(round(rem/2)-rem/2);
      rem=round(rem/2);
      slice5(y,x)=round(round(rem/2)-rem/2);
      rem=round(rem/2);
      slice6(y,x)=round(round(rem/2)-rem/2);
      rem=round(rem/2);
      slice7(y,x)=round(round(rem/2)-rem/2);
      rem=round(rem/2);
      slice8(y,x)=round(round(rem/2)-rem/2);
  end
end
