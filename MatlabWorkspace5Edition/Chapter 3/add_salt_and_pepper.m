function noised = add_salt_and_pepper(image,level)
%Replace image values by black or white, randomly
%
%  Usage: new image =  add_salt_and_pepper(image,level)
%
%  Parameters: image   - array of points 
%              level   - controls the amount of noise,
%                        try 0 (no noise), 0.01 (little noise), 0.1 (noisy)

%get dimensions
[rows,cols]=size(image);
noised=zeros(rows,cols);

for x = 1:cols %address all columns 
  for y = 1:rows %address all rows
      noised(y,x)=image(y,x);
      if rand>(1-level)
        noised(y,x)=255; %white
      else if rand<level
              noised(y,x)=0; %black
          end
      end
  end
end
