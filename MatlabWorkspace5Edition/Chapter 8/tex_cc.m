function coocc = tex_cc(image,dist,dirs)
%Generate co-occurrence matrix
%
%  Usage: [new image] = tex_cc(image,dist,dirs)
%
%  Parameters:  image - array of points 
%               dist  - length of vector (e.g. 2)
%               dirs  - gradiation of distance (e.g. 4)
%
%  Author: Mark S. Nixon

%get dimensions
[rows,cols]=size(image); 
%clear output image
coocc(1:256,1:256)=0;

for x = 1:cols %address all columns
    for y = 1:rows %address all rows
        for r = 1:dist %and cover all radii
            for theta = 0:2*pi/dirs:2*pi*(1-1/dirs) %and angles in radians
                xc=round(x+r*cos(theta));
                yc=round(y+r*sin(theta));
                %check coordinates within image
                if yc>0&&yc<=rows&&xc>0&&xc<=cols
                    %image brightness is 0..2^(N-1) so add 1 (for 1..2^N)
                    coocc(image(y,x)+1,image(yc,xc)+1)=...
                       coocc(image(y,x)+1,image(yc,xc)+1)+1;
                end
            end
        end
    end
end