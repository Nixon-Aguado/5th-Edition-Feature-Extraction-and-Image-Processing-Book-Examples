function output_median = median(image,winsize)
%New image point brightness = median of points in window
%
%  Usage: new image = image_median(image,window size)
%
%  Parameters: image      - array of points 
%              winsize    - size of window (odd, integer)

%get dimensions
[rows,cols]=size(image);

%set the output image and hence border points to black
output_median(1:rows,1:cols)=0;

%half of template is
half=floor(winsize/2); 

%then get the median as the middle of the ranked points in the window
for x = half+1:cols-half %address all columns except border
  for y = half+1:rows-half %address all rows except border
    i=1; %initialise a vector pointer
    for iwin = 1:winsize %address template columns
      for jwin = 1:winsize %address template rows
        vector(i)=image(y+jwin-1-half,x+iwin-1-half); %turn window into vector
        i=i+1; %update pointer
      end
    end
    %and then sort the vector by element values
    sorted_vector=sort(vector);
    %and take the middle point
    output_median(y,x)=sorted_vector(half*winsize+half+1); 
  end
end
