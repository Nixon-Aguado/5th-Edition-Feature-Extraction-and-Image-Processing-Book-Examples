function image = template_match_Fourier(image,template)
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

%step up Monsieur Fourier
accum=ifft2(rearrange(fft2(rearrange(image)).*conj(fft2(rearrange(pad(image,template))))));

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