function filtered = bilateral_filter(image,domainsize,rangesize,st_devd,st_devr)
%New image point brightness = intensity weighted Gaussian filter
%
%  Usage: new image = bilateral_filter(image,window size domain, window size range, domain standard deviation, range standard deviation)
%
%  Parameters: image      - array of points 

%              winsize    - size of window (odd, integer)
%              st_dev     - standard deviation of weighting function

%get image dimensions
[rows,cols]=size(image);

%set the output image to black
filtered(1:rows,1:cols)=0;
weights(1:rows,1:cols)=0;

%half of domain template is
halfd=floor(domainsize/2); 

%process points according to largest window function
if domainsize>rangesize
    border=halfd;
else
    border=floor(rangesize/2); 
end
    
%we start by looking at all image points except those in the border
%start with calculating weights for domain filter
for x = border+1:cols-border 
  for y = border+1:rows-border
      %need to total up the weights (for later normalisation)
      weightsum=0;
      for iwin = 1:domainsize
        for jwin = 1:domainsize
            %evaluate a normal Gaussian spatial weight, Eq. 3.33
            weightp=exp(-((x+iwin-halfd-1-x)^2+(y+jwin-halfd-1-y)^2)/(2*st_devd*st_devd));
            %and add up the weights
            weightsum=weightsum+weightp;
        end
      end
      weights(y,x)=weightsum;
      end     
    end

%half of range template is
halfr=floor(rangesize/2); 

%now include the range filter weights
for x = border+1:cols-border 
  for y = border+1:rows-border
      %need to total up the weights (for later normalisation)
      weightsum=0;
      %need to total up the weighted points
      productsum=0;
      for iwin = 1:rangesize
        for jwin = 1:rangesize
            %include a weight based on intensity difference, Eq. 3.34
            weightp=weights(y,x)*exp(-(image(y+jwin-halfr-1,x+iwin-halfr-1)-image(y,x))^2/(2*st_devr*st_devr));
            %and add a weighted amount of the image information, Eq. 3.35
            productsum=productsum+weightp*image(y+jwin-halfr-1,x+iwin-halfr-1);
            %and add up the weights
            weightsum=weightsum+weightp; %sum weights kb
        end
      end
      filtered(y,x)=floor(productsum/weightsum); %normalise
      end     
    end
end