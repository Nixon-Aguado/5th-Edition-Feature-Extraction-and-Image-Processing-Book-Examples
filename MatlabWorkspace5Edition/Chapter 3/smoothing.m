eye=imread('rock.png');
eye=double(eye(:,:,1));
noisy=add_Gaussian_noise(eye,2);
colormap(gray)
imagesc(noisy)
a=ave(noisy,9);
imagesc(noisy)
imagesc(a)
b=template_convolve(noisy,gaussian_template(9,1.4));
imagesc(b)
f=non_local_means(eye,9,40,50);
imagesc(f)
t=histogram(noisy-eye);
u=histogram(noisy-a);
v=histogram(noisy-b);
x=histogram(noisy-f);
hold off
plot(t(1:20))
hold on
plot(v(1:20))
plot(x(1:20))