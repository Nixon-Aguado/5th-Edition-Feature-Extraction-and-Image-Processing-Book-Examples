function filtered = non_local_means(image,winsize,searchsize,st_dev)
%New image point brightness = semi local mean of points in window
%
%  Usage: new image = non_local_means(image,window size,standard deviation)
%
%  Parameters: image      - array of points 
%              winsize    - size of window (odd, integer)
%              st_dev     - standard deviation of weighting function

%get image dimensions
[rows,cols]=size(image);

%set the output image to black
filtered(1:rows,1:cols)=0;
local_mean(1:rows,1:cols)=0;

%half of template is
halfwin=floor(winsize/2); 
%and half of the search
halfsearch=floor(searchsize/2);

%process points according to largest window function
if winsize>searchsize
    border=halfwin; %normal case
else
    border=halfsearch; %which is possible, but daft
end

%then form the local averages
local_mean=(ave(image,winsize));

%we start by looking at all image points except those in the border
for x = border+1:cols-border 
  for y = border+1:rows-border
      %need to total up the weights (for later normalisation)
      weightsum=0;
      %need to total up the weighted points
      productsum=0;
      for iwin = 1:searchsize
        for jwin = 1:searchsize
            % Gaussian weight based on the intensity difference %Eq. 3.31
            weightp=exp(-(local_mean(y+jwin-halfsearch-1,x+iwin-halfsearch-1)-...
                                local_mean(y,x))^2/(2*st_dev*st_dev));
            %and add a weighted amount of the image information
            productsum=productsum+weightp*... %Eq 3.32
                                image(y+jwin-halfsearch-1,x+iwin-halfsearch-1);
            %and add up the weights
            weightsum=weightsum+weightp;
        end
      end
      filtered(y,x)=floor(productsum/weightsum);
  end
end
