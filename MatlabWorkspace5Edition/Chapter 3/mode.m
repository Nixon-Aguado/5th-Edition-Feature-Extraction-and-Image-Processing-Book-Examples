function filtered = mode(image,winsize)
%New image point brightness = mode of points in window
%
%  Usage: [new image] = mode(image,window size)
%
%  Parameters: image      - array of points 
%              winsize    - size of window (odd, integer)

%get dimensions
[rows,cols]=size(image);

filtered(1:rows,1:cols)=0;

%half of template is
half=floor(winsize/2); 

for x = half+1:cols-half %address all columns except border
  for y = half+1:rows-half %address all rows except border
    win=image(y-half:y+half,x-half:x+half);
    imedian=median(median(win)); %median of region
    iaverage=mean(mean(win)); %mean of region
    upper=2*imedian-min(min(win)); %decide upper truncation
    lower=2*imedian-max(max(win)); %decide lower truncation
    cc=1; %store points in vector
    for ix=1:winsize %address cols of region
        for jy=1:winsize %address cols of region
            if (win(jy,ix)<upper)&&(imedian<iaverage)
                trunc(cc)=win(jy,ix); %store points within truncation
                cc=cc+1; %update pointer
            end
            if (win(jy,ix)>lower)&&(imedian>iaverage)
                trunc(cc)=win(jy,ix); %store points within truncation
                cc=cc+1; %update pointer
            end
        end
    end
    if cc>winsize %as long as we have enough points
        filtered(y,x)=median(trunc); %get median of 
    else                             %truncated region
        filtered(y,x)=imedian;       %else get
    end                              %median of window
  end
end
                