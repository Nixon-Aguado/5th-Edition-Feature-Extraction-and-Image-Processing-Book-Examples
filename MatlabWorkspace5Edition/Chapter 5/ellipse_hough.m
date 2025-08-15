function pic = ellipse_hough(image,arad,brad)
%Accumulator from Hough transfrom
%
%  Usage: [new image] = ellipse_hough(image)
%
%  Parameters: sizes of ellipse in x=arad and y=brad

%get dimensions
[rows,cols]=size(image);

%set the output accumulator to black (0)
accum(1:rows,1:cols)=0;

%and an output image
pic(1:rows,1:cols)=0;

for x = 1:cols %address all columns
    for y = 1:rows %address all rows
        if image(y,x)>80
            for theta=1:360
                xdash=round(arad*cos(theta*pi/180));
                ydash=round(brad*sin(theta*pi/180));
                if (((x+xdash)<cols)&&((x+xdash)>0)&&...
                        ((y+ydash)<rows)&&((y+ydash)>0))
                    accum(y+ydash,x+xdash)=accum(y+ydash,x+xdash)+1;
                end
            end
        end
    end
end

%find the maximum
biggest_vote=max(max(accum));

for x = 1:cols %address all columns 
    for y = 1:rows %address all rows
        if accum(y,x)==biggest_vote
            centrex=x;
            centrey=y;
      end
  end
end

disp('the ellipse was centred at')
centrex
centrey


%now add the detected ellipse to the original image
pic=image;
for theta=1:360
    xdash=round(arad*cos(theta*pi/180));
    ydash=round(brad*sin(theta*pi/180));
    if (((centrex+xdash)<cols)&&((centrex+xdash)>0)&&((centrey+ydash)<rows)&&((centrey+ydash)>0))
        pic(centrey+ydash,centrex+xdash)=512;
    end
end

