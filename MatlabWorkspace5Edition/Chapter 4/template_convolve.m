function convolved = template_convolve(image,template)
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
convolved(1:rows,1:cols)=0;

%then convolve the template
for x = tc+1:cols-tc %address all columns except border
    for y = tr+1:rows-tr %address all rows except border
        sum=0; %initialise the sum
        for iwin=1:tcols %address all points in the template
            for jwin=1:trows
                sum=sum+image(y+jwin-tr-1,x+iwin-tc-1)*...
                           template(trows-jwin+1,tcols-iwin+1);
            end
        end
        convolved(y,x)=sum;
    end
end