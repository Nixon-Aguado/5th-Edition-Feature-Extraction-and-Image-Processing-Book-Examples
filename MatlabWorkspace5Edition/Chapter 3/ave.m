function averaged = ave(image,winsize)
%New image point brightness = average of winsize*winsize region in image
%
%  Usage: [new image] = ave(image,winsize)
%
%  Parameters: image      - array of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
averaged(1:rows,1:cols)=0;

%set the border
half=floor(winsize/2);

%then form the average of the points
for x = half+1:cols-half %address all columns except border
    for y = half+1:rows-half %address all rows except border
         summed=0; %initialise the sum
        for iwin=1:winsize %address all points to be averaged
            for jwin=1:winsize
                summed=summed+image(y-half+jwin-1,x-half+iwin-1);
            end
        end
        %finally, divide by sum of template coefficients
        averaged(y,x)=floor(summed/(winsize*winsize));
    end
end
