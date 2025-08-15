function image = line_hough(image, maxr)
%Polar HT for lines
%
%  Usage: [new image] = line_hough(image)
%
%  Parameters: just an image

%get dimensions
[rows,cols]=size(image);

%set the radius limit
rmax=round(sqrt(rows*rows+cols*cols));

%we'll use 90 directions
maxdir=30;


%now set the accumulator
acc(1:rmax,1:maxdir)=0;

edges=Sobel(image);

for x = 1:cols %address all columns 
  for y = 1:rows %address all rows
      for rad = 1:rmax
          if edges(y,x)>80
              for theta=1:maxdir
                  phi=theta*pi/maxdir;
                  p=round(x*cos(phi)+y*sin(phi));
                  if (p<rmax && p>0)
                      acc(p,theta)=acc(p,theta)+1;
                  end
              end
          end
      end
  end
end

%find the maximum in the accumulator
biggest_vote=max(max(acc));

%find the co-ordinates of the maximum 
for y = 1:rmax %address all columns 
  for x = 1:maxdir %address all rows
      if acc(y,x) == biggest_vote
          pmax=y;
          thetamax=x;        
      end
  end
end

disp('the line was centred at')
pmax
disp ('radius')
thetamax

%now draw the line on the image
for x = 1:cols
    for y = 1:rows
        phi=thetamax*pi/maxdir;
        if round(x*cos(phi)+y*sin(phi)-pmax)==0
            image(y,x)=255;
        end
    end
end
      



