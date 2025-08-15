function codes = uniform_lbp(image, dirs, rad)
%Generate uniform (scale and rotation invariant) LBP codes
%
%  Usage: [new image] = uniform_lbp(image,dist,dirs)
%
%  Parameters:  image - array of points 
%               rad  - R in 8.21 (e.g. 2)
%               dirs  - P in 8.21 (e.g. 8)

%get dimensions
[rows,cols]=size(image); 
%clear output
codes(1:rows,1:cols)=0;

for x = rad+1:cols-rad-1 %address all columns except border
    for y = rad+1:rows-rad-1 %address all rows except border
        counter=0; %initialise i 
        code_p=0;  %and temporary summation
        for theta = 0:2*pi/dirs:2*pi*(1-1/dirs) %angles in radians
            xc=round(x+rad*cos(theta));
            yc=round(y+rad*sin(theta));
            if image(yc,xc)>image(y,x) %eq 8.19
                code_p(counter+1)=1; %generate points
            else
                code_p(counter+1)=0; %point 0
            end
            counter=counter+1; %increment i
        end
        zero_crossings=0; %eq 8.24 
        for i=1:counter-1 %now count the zero crossings
            if code_p(i)~=code_p(i+1)
                zero_crossings=zero_crossings+1;
            end
        end %and check start to end transition
        if code_p(1)~=code_p(counter)
            zero_crossings=zero_crossings+1;
        end
        if zero_crossings<3 %eq 8.25
            codes(y,x)=0;
            for i=1:counter %sum up the set bits
                codes(y,x)=codes(y,x)+code_p(i);
            end
        else
            codes(y,x)=9; %defaults to no code
        end
    end
end

