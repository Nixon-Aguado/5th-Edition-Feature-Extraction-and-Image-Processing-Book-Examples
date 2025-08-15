function Mag_Prewitt = mag_Prewitt(image)
%New image point brightness = magnitude of Prewitt operator
%
%  Usage: [new image] = mag_Prewitt(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
Mag_Prewitt(1:rows,1:cols)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    Prewitt_y=image(y-1,x-1)+image(y-1,x)+image(y-1,x+1)-...
             image(y+1,x-1)-image(y+1,x)-image(y+1,x+1);
    Prewitt_x=image(y-1,x-1)+image(y,x-1)+image(y+1,x-1)-...
             image(y-1,x+1)-image(y,x+1)-image(y+1,x+1);
    Mag_Prewitt(y,x)=floor(sqrt(Prewitt_x*Prewitt_x+Prewitt_y*Prewitt_y));
  end
end