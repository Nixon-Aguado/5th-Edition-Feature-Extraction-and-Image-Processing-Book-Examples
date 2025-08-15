function pic = circle_hough(image, maxr)
%Accumulator from Hough transfrom
%
%  Usage: [new image] = circle_hough(image)
%
%  Parameters: just an image and maximum radius. Internally, radii start
%  from 10.

%get dimensions
[rows,cols]=size(image);

%set a start radius
startr=10;

%set the output image to black (0)
accum(1:rows,1:cols,1:(maxr-startr+1))=0;

%and an output image
pic(1:rows,1:cols)=0;

for x = 1:cols %address all columns 
  for y = 1:rows %address all rows
      for rad = startr:maxr
          if image(y,x)>80
              for theta=1:360
                  xdash=round(rad*cos(theta*pi/180));
                  ydash=round(rad*sin(theta*pi/180));
                  if (((x+xdash)<cols)&&((x+xdash)>0)&&...
                      ((y+ydash)<rows)&&((y+ydash)>0))
                      accum(y+ydash,x+xdash,rad-startr+1)=...
                          accum(y+ydash,x+xdash,rad-startr+1)+1;
                  end
              end
          end
      end
  end
end

%find the maximum
biggest_vote=max(max(max(accum)));

for x = 1:cols %address all columns 
  for y = 1:rows %address all rows
      for rad = startr:maxr
          if accum(y,x,rad-startr+1)==biggest_vote
              centrex=x;
              centrey=y;
              radius=rad;
          end
      end
  end
end

disp('the circle was centred at')
centrex
centrey
disp ('radius')
radius

%now add the detected circle to the original image
pic=image;
for theta=1:360
    xdash=round(radius*cos(theta));
    ydash=round(radius*sin(theta));
    if (((centrex+xdash)<cols)&&((centrex+xdash)>0)&&((centrey+ydash)<rows)&&((centrey+ydash)>0))
        pic(centrey+ydash,centrex+xdash)=700;
    end
end
      



