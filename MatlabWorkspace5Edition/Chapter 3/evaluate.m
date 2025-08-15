function d = evaluate(level)
a=imread('smallhippo.bmp','bmp');
a=double(a(:,:,1));
b=add_Gaussian_noise(a,level);
c=uint8(b);
imwrite(c,'noisyhippo.bmp')