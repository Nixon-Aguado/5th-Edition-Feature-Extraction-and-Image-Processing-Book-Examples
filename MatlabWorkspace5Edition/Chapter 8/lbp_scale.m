function codes = lbp_scale(image, dirs, rad)
%Generate scale invariant LBP codes
%
%  Usage: [new image] = tex_cc(image,dist,dirs)
%
%  Parameters:  image - array of points 
%               rad  - R in 8.21 (e.g. 2)
%               dirs  - P in 8.21 (e.g. 8)

%get dimensions
[rows,cols]=size(image); 
%clear output
codes(1:256)=0;

for x = rad+1:cols-rad-1 %address all columns
  for y = rad+1:rows-rad-1 %address all rows
    counter=0; %initialise i
    code_p=0;  %and temporary summation
    for theta = 0:2*pi/dirs:2*pi*(1-1/dirs) %angles in radians
        xc=round(x+rad*cos(theta));
        yc=round(y+rad*sin(theta));
            if image(yc,xc)>image(y,x) %eq 8.19
                code_p=code_p+2^counter; %generate code 8.20
            counter=counter+1; %increment i
         end %and then add to histogram
        codes(code_p+1)=codes(code_p+1)+1;
    end
  end
end