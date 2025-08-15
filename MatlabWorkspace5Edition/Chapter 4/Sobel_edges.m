function edge = Sobel_edges(image)
% Gives Sobel for Canny operator
%
%  Usage: [new image] = Sobel_edges(image)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
edge(1:rows,1:cols,3)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    Sobel_y=image(y+1,x+1)+2*image(y+1,x)+image(y+1,x-1)-...
             image(y-1,x+1)-2*image(y-1,x)-image(y-1,x-1);
    Sobel_x=image(y-1,x+1)+2*image(y,x+1)+image(y+1,x+1)-...
             image(y-1,x-1)-2*image(y,x-1)-image(y+1,x-1);
    edge(y,x,1)=Sobel_x;
    edge(y,x,2)=Sobel_y;
    edge(y,x,3)=floor(sqrt(Sobel_x*Sobel_x+Sobel_y*Sobel_y));
  end
end