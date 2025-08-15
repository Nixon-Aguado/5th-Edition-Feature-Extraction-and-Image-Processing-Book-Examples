function image = template_match(image,template)
%New image point brightness convolution of template with image
%  Usage: [new image] = convolve(image,template of point values)
%
%  Parameters: image      - array of points
%              template   - array of weighting coefficients
 
%get image dimensions
[rows,cols]=size(image);

%get template dimensions
[trows,tcols]=size(template);
 
%half of template rows is
tr=floor(trows/2);
 
%half of template cols is
tc=floor(tcols/2);

%set an output as black
accum(1:rows,1:cols)=0;

%then convolve the template
for x = tc+1:cols-tc %address all columns except border
    for y = tr+1:rows-tr %address all rows except border
        sum=0; %initialise the sum
        for iwin=1:tcols %address all points in the template
            for jwin=1:trows
                sum=sum+image(y+jwin-tr-1,x+iwin-tc-1)*...
                           template(jwin,iwin);
            end
        end
        accum(y,x)=sum;
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

disp('the shape started at')
centrex
centrey

%now add the template to the image
image(centrey-tr:centrey+tr,centrex-tc:centrex+tc)=...
    image(centrey-tr:centrey+tr,centrex-tc:centrex+tc)+2*template(1:tcols,1:trows);
end

