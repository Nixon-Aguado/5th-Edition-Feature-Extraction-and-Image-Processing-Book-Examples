function image = gen_circle(imsize,radius)
% circtle to test DST
%
% Usage: circle= gen_circle(imsize,radius)
%        imsize = N for N*N image
%        radius is of circle at centre
%        generages magnitude and direction (to replace edge operator
               
image(1:imsize,1:imsize,2)=0;

%define centre coordinates
cen_x=floor(imsize/2);
cen_y=floor(imsize/2);

for i=1:imsize
    for j=1:imsize
        if abs((i-cen_x)*(i-cen_x)+(j-cen_y)*(j-cen_y)-radius*radius)<10
            image(j,i,1)=255;
            image(j,i,2)=pi/2-atan((i-cen_x)/(j-cen_y));
        end
    end
end
            