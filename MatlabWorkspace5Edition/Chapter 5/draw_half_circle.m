function image = draw_half_circle(image,xc, yc, rad)

%get dimensions
[rows,cols]=size(image);

%clear image
image(1:rows,1:cols)=0;

%draw a circle of points
for theta=1:180
    xd=round(xc+rad*cos(theta*pi/180));
    yd=round(yc+rad*sin(theta*pi/180));
    if ((xd<cols)&&(xd>0)&&(yd<rows)&&(yd>0))
        image(yd,xd)=255;
    end
end