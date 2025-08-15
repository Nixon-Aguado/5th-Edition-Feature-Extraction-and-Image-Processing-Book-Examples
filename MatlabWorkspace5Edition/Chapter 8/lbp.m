function codes = lbp(image)
%Generate basic LBP codes
%
%  Usage: vector of codes = lbp(image)
%
%  Parameters:  image - array of points 


%get dimensions
[rows,cols]=size(image); 
%clear output histogram
codes(1:256)=0;

for x = 2:cols-1 %address all columns
  for y = 2:rows-1 %address all rows
    weight=1; %initialise weight
    code_p=0;  %and temporary summation
    for xc = x-1:x+1 %cover 3*3 window
        for yc=y-1:y+1
            if ~(xc==x&&yc==y) %avoid middle point
                if image(yc,xc)>image(y,x) %eq 8.19
                    code_p=code_p+weight; %generate code 8.20
                end
                weight=weight*2; %update weight
            end
        end %and then add to histogram
        codes(code_p+1)=codes(code_p+1)+1;
    end
  end
end
