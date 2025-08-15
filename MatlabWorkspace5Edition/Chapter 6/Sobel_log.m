function edge = Sobel_log(image)
%New image point brightness = log magnitude of Sobel operator (for DST)
%
%  Usage: [new image] = Sobel_log(image)
%
%  Parameters: images of magnitude and phase      - arrays of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
edge(1:rows,1:cols,2)=0;

%then form the difference
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    Sobel_y=image(y-1,x-1)+2*image(y-1,x)+image(y-1,x+1)-...
             image(y+1,x-1)-2*image(y+1,x)-image(y+1,x+1);
    Sobel_x=image(y-1,x-1)+2*image(y,x-1)+image(y+1,x-1)-...
             image(y-1,x+1)-2*image(y,x+1)-image(y+1,x+1);
    edge(y,x,1)=log(1+sqrt(Sobel_x*Sobel_x+Sobel_y*Sobel_y));
    edge(y,x,2)=atan(Sobel_y/Sobel_x);
        % edge(y,x,2)=atan(Sobel_y/Sobel_x)+(pi/2);
    if (edge(y,x,1)==0) edge(y,x,2)=0; end
    if (Sobel_y==0)&&(Sobel_x>0) 
        edge(y,x,2)=pi; 
    end
    if (Sobel_y==0)&&(Sobel_x<0) 
        edge(y,x,2)=0; 
    end
  end
end