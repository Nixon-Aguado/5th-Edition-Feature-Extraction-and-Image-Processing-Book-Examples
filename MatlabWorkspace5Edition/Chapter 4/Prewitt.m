function edge = Prewitt(image)
%New image point brightness = magnitude of Prewitt operator
%
%  Usage: [new image] = mag_Prewitt(image)
%
%  Parameters: images of magnitude and phase      - arrays of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
edge(1:rows,1:cols,2)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
      Prewitt_y=image(y-1,x-1)+image(y-1,x)+image(y-1,x+1)-...
                image(y+1,x-1)-image(y+1,x)-image(y+1,x+1);
      Prewitt_x=image(y-1,x-1)+image(y,x-1)+image(y+1,x-1)-...
                image(y-1,x+1)-image(y,x+1)-image(y+1,x+1);
      %magnitude, Eq. 4.12
      edge(y,x,1)=floor(sqrt(Prewitt_x*Prewitt_x+Prewitt_y*Prewitt_y));
      %direction, Eq. 4.13
      edge(y,x,2)=floor(sqrt((atan(Prewitt_y/Prewitt_x)+(pi/2))*180/pi));
  end
end