function equalised = equalise(image)
%Nonlinear histogram equalisation
%
%  Usage: [new image] = equalise(image)
%
%  Parameters: image  - array of integers, in range 0..255

%get dimensions
[rows,cols]=size(image); 

%specify range of levels
range=255;

%and the number of points
number=cols*rows;

%initialise the image histogram
hist(1:256)=0;  % 1..256 = 0..255

%work out the histogram
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    hist(image(y,x)+1)=hist(image(y,x)+1)+1;
  end
end;

%evaluate the cumulative histogram
sum=0;
for i=1:256
  sum=sum+hist(i);
  cumhist(i)=floor(sum*range/number); %Eq. 3.9
end

%map using the cumulative histogram
for x = 1:cols %address all columns
  for y = 1:rows %address all rows
    equalised(y,x)=cumhist(image(y,x)+1); %Eq 3.10
  end
end

