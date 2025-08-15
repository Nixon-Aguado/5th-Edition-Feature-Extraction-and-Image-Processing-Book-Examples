function Sobel = phase_Sobel(image)
%New image point brightness = phase of Prewitt operator
%
%  Usage: [new image] = phase_Prewitt(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
Sobel(1:rows,1:cols)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    Sobely=image(y-1,x-1)+2*image(y-1,x)+image(y-1,x+1)-...
           image(y+1,x-1)-2*image(y+1,x)-image(y+1,x+1);
    Sobelx=image(y-1,x-1)+2*image(y,x-1)+image(y+1,x-1)-...
           image(y-1,x+1)-2*image(y,x+1)-image(y+1,x+1);
    Sobel(y,x)=floor(sqrt((atan(Sobely/Sobelx)+(pi/2))*180/pi));
  end
end