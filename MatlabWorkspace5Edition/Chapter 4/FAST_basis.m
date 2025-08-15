function corner = FAST_basis(image,threshold)
%New image point brightness = corners by basis of FAST
%
%  Usage: [image of corner locations] = FAST_basis(image,threshold)
%
%  Parameters: image      - array of points
%               threshold - integer

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
corner(1:rows,1:cols)=0;

for x = 4:cols-4 %address all columns except border
  for y = 4:rows-4 %address all rows except border
  %check compass points aboce threshold
  count1=0;
  if image(y-3,x)>threshold
      count1=count1+1;
  end
  if image(y+3,x)>threshold
      count1=count1+1;
  end
  if image(y,x+3)>threshold
      count1=count1+1;
  end
  if image(y,x-3)>threshold
      count1=count1+1;
  end
  %check compass points less than threshold
  count2=0;
  if image(y-3,x)<threshold
      count2=count2+1;
  end
  if (image(y+3,x))<threshold
      count2=count2+1;
  end
  if image(y,x+3)<threshold
      count2=count2+1;
  end
  if image(y,x-3)<threshold
      count2=count2+1;
  end
  %if they meet condition check the rest
  if ((count1>2)||(count2>2))
      %first do NE corner. then NW, SE and finally SW
      if (image(y-3,x+1)>image(y,x)&&...
          image(y-2,x+2)>image(y,x)&&...
          image(y-1,x+3)>image(y,x)&&...
          image(y-3,x-1)>image(y,x)&&...
          image(y-2,x-2)>image(y,x)&&...
          image(y-1,x-3)>image(y,x)&&...
          image(y+3,x+1)>image(y,x)&&...
          image(y+2,x+2)>image(y,x)&&...
          image(y+1,x+3)>image(y,x)&&...
          image(y+3,x-1)>image(y,x)&&...
          image(y+2,x-2)>image(y,x)&&...
          image(y+1,x-3)>image(y,x))
      corner(y,x)=255;
      end
  end
  end
end
