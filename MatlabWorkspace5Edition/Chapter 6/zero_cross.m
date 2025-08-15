function zero_xing = zero_cross(image)
%New image shows zero crossing points
%
%  Usage: [new image] = zero_cross(image)
%
%  Parameters: image      - array of points from application of LoG

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
zero_xing(1:rows,1:cols)=0;

%then form the four quadrant points
for x = 2:cols-1 %address all columns except border
  for y = 2:rows-1 %address all rows except border
    int(1)=image(y-1,x-1)+image(y-1,x)+image(y,x-1)+image(y,x);
    int(2)=image(y,x-1)+image(y,x)+image(y+1,x-1)+image(y+1,x);
    int(3)=image(y-1,x)+image(y-1,x+1)+image(y,x)+image(y,x+1);
    int(4)=image(y,x)+image(y,x+1)+image(y+1,x)+image(y+1,x+1);
    %now work out the max and min values
    maxval=max(int);
    minval=min(int);
    %and label it as zero crossing if there is one (!)
    if (maxval>0)&&(minval<0) 
        zero_xing(y,x)=255; 
    end
  end
end
