function shifted = shift(image,shift_x,shift_y)
%Shifts an image horizontally and vertically, and wraps round
%
%  Usage: [new image] = shift_y(image,amount x axis, amount y axis)
%
%  Parameters: image      - array of points 
%              shift_x    - amount of x shift
%              shift_y    - amount of y shift

%get dimensions
[rows,cols]=size(image); 

%and shift it (with side to side and top to bottom wrap around)
for x=1:cols %% along the horizontal axis 
    for y=1:rows %% down the vertical axis
        shifted(y,x)=image(mod(y+shift_y-1,rows)+1,mod(x+shift_x-1,cols)+1);
    end
end
