function output_median = their_median(image,winsize)
%New image point brightness = median of points in window
%
%  Usage: [new image] = their_median(image,window size)
%
%  Parameters: image      - array of points 
%              winsize    - size of window (odd, integer)

%get dimensions
[rows,cols]=size(image);

%set the output image and hence border points to to black
output_median(1:rows,1:cols)=0;

%half of template is
half=floor(winsize/2); 

%then get the median as the middle of the ranked points in the window
for x = half+1:cols-half %address all columns except border
  for y = half+1:rows-half %address all rows except border
      %note this is an approximation by the double median
      output_median(y,x)=median(median(image(y-half:y+half,x-half:x+half)));
  end
end
