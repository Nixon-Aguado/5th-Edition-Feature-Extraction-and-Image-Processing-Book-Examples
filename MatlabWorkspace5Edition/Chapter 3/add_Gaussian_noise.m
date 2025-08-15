function noisy_image = add_Gaussian_noise(image,level)
%Add mean-zero Gaussian noise
%
%  Usage: new image =  add_Gaussian_noise(image,number)
%
%  Parameters: image   - array of points 
%              level   - controls the amount of noise

%get dimensions
[rows,cols]=size(image);

noisy_image(1:rows,1:cols)=0;

%now check everything is within pixel range
for x = 1:cols %address all columns 
  for y = 1:rows %address all rows
     noisy_image(y,x)=image(y,x)+(randn*level); 
     if noisy_image(y,x)>255
        noisy_image(y,x)=255; %white
      else if noisy_image(y,x)<0
              noisy_image(y,x)=0; %black
          end
      end
  end
end
