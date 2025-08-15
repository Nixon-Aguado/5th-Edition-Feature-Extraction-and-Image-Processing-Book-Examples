function snd_order = LoG_template(winsize,sigma)
%To form a Laplacian of Gaussian template
%
%  Usage: [new image] = LoG_template(winsize,sigma)
%
%  Parameters: winsize    - size of template
%              sigma      - standard deviation of template

half=floor(winsize/2)+1;
snd_order(1:winsize,1:winsize)=0;

%then form the LoG template
sum=0;
for x = 1:winsize %address all columns
  for y = 1:winsize %address all rows except border
    snd_order(y,x)= (1/(sigma^2))*((((x-half)^2+(y-half)^2)/sigma^2)-2)*...
        exp(-(((x-half)^2+(y-half)^2)/(2*sigma^2)));
    sum=sum+snd_order(y,x);
  end
end
snd_order=snd_order/sum;
end

