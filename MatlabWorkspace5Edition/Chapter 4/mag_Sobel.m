function Sobel = mag_Sobel(image)
%New image point brightness = magnitude of Sobel operator
%
%  Usage: [new image] = mag_Sobel(image)
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
    Sobel(y,x)=floor(sqrt(Sobely*Sobely+Sobelx*Sobelx));
  end
end