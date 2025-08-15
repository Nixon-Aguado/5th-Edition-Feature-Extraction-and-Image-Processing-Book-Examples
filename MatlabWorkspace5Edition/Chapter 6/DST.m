function symmetry = DST(image,sigma,edges)
% Discrete symmetry transform
%
%  Usage: symmetry image  = DST(image)
%
%  Parameters:  sigma = variance oif distance weighting
%               edges = edges from Sobel_log(image)          

[rows,cols]=size(image);

symmetry(1:rows,1:cols)=0;

for x = 1:cols %address all columns 
  for y = 1:rows %address all rows
      if edges(y,x,1)>0
          for xx = 1:cols %address all columns
              for yy = 1:rows %address all rows
                  %check edge magnitude and points not the same
                  if (edges(yy,xx,1)>0&&(x~=xx)&&(y~=yy))
                      %evaluate weighted distance
                      dist=(1/sqrt(2*pi*sigma))*exp(-(sqrt((xx-x)*(xx-x)+(yy-y)*(yy-y))/(2*sigma)));
                      %and the phase
                      alpha=atan((yy-y)/(xx-x));
                      % alpha=atan((yy-y)/(xx-x))+(pi/2);
                      pha=(1-cos(edges(y,x,2)+edges(yy,xx,2)-2*alpha))*(1-cos(edges(y,x,2)-edges(yy,xx,2)));
                      %now evaluate the symmetry
                      symm=dist*pha*edges(y,x,1)*edges(yy,xx,1);
                      %and plot it at the mid point of the two points
                      symmetry(floor((y+yy)/2),floor((x+xx)/2))=symmetry(floor((y+yy)/2),floor((x+xx)/2))+symm;
                  end
              end
          end
      end
  end
end

                      
                      