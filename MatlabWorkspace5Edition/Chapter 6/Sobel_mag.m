function edge = Sobel_mag(image)
%New image point brightness = magnitude of Prewitt operator
%
%  Usage: [new image] = Sobel(image)
%
%  Parameters: images of magnitude and phase      - arrays of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
edge(1:rows,1:cols)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    Sobel_y=image(y-1,x-1)+2*image(y-1,x)+image(y-1,x+1)-...
             image(y+1,x-1)-2*image(y+1,x)-image(y+1,x+1);
    Sobel_x=image(y-1,x-1)+2*image(y,x-1)+image(y+1,x-1)-...
             image(y-1,x+1)-2*image(y,x+1)-image(y+1,x+1);
    edge(y,x)=floor(sqrt(Sobel_x*Sobel_x+Sobel_y*Sobel_y));
  end
end