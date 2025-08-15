function Prewitt = phase_Prewitt(image)
%New image point brightness = phase of Prewitt operator
%
%  Usage: [new image] = phase_Prewitt(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
Prewitt(1:rows,1:cols)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    Prewitty=image(y-1,x-1)+2*image(y-1,x)+image(y-1,x+1)-...
           image(y+1,x-1)-2*image(y+1,x)-image(y+1,x+1);
    Prewittx=image(y-1,x-1)+2*image(y,x-1)+image(y+1,x-1)-...
           image(y-1,x+1)-2*image(y,x+1)-image(y+1,x+1);
    Prewitt(y,x)=floor(sqrt((atan(Prewitty/Prewittx)+(pi/2))*180/pi));
  end
end