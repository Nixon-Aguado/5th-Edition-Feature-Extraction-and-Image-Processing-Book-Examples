function h_peaks = hyst_thr(h_peaks,upper,lower)
%Function finding points above the upper theshold
%
%  Usage: [new image] = hyst_thr(non max suppressed image, tu, tl)
%
%  Parameters: non max suppressed image, upper, lower threshold

%get dimensions
[rows,cols]=size(h_peaks);

for x = 2:cols-2 %address all 3 columns
  for y = 2:rows-2 %address all 3 rows
  %start by finding point above upper threshold
      if (h_peaks(y,x)>=upper)&&(h_peaks(y,x)~=255)
          h_peaks(y,x)=255; %label it as white
          h_peaks=connect(x,y,h_peaks,lower); %and look for neighbours
      end
  end
end