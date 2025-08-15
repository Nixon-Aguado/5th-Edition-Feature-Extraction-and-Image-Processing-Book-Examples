function c_peaks = connect(xc,yc,c_peaks,lower)
%Function connecting points above the lower theshold
%
%  Usage: [new image] = connect(non max suppressed image)
%
%  Parameters: coordinates, non max suppressed image, lower threshold

%get dimensions
[rows,cols]=size(c_peaks);

%address 3*3 neighbourhood
for x = xc-1:xc+1 %address all 3 columns
    for y = yc-1:yc+1 %address all 3 rows
      %if point above lower threshold and within image
      if (x>1)&&(x<cols)&&(y>1)&&(y<rows)&&...
                (c_peaks(y,x)>=lower)&&(c_peaks(y,x)~=255)
          c_peaks(y,x)=255; %label it as white
          c_peaks=connect(x,y,c_peaks,lower); %and look for more
      end
    end
end