%Chapter 3 Basic Image Processing Operations

disp ('Welcome to the Chapter3 script')
disp ('This worksheet is the companion to Chapter 3 and is an introduction.')
disp ('The worksheet follows the text directly and allows you to process basic images.')

%Let's initialise the display colour
colormap(gray);

%And let's start with empty memory
clear

disp (' ')
disp ('Let us use an image.')
%if you want the eye it's
eye=imread('eye_orig.jpg','jpg');
%images are stored as integers, so we need to double them for Matlab
%we also need to ensure we have a greyscale, not three colour planes 
eye=double(eye(:,:,1));
disp ('Let us see the top left hand corner')
%print out top left corner
eye(1:10,1:10)
%and display it as an image
%we need to scale for the early section of this chapter only, using a minimum
mini=min(min(eye));
%and a maximum
maxi=max(max(eye));
subplot (1,1,1), imagesc(eye, [mini maxi])
plotedit on, title ('Original image'), plotedit off
disp ('When you are ready to move on, press RETURN') 
pause;

%Let's show its dimensions
%disp (' ')
%disp ('The size of this image is')
%size(eye)

disp (' ')
disp ('Let us have a look at its histogram. This is a count of all pixels with a ')
disp ('specified brightness level, plotted against brightness level.') 
%We can calculate it by invoking the function histogram.m
hist_eye=histogram(eye);
%now we shall plot it
plot(hist_eye);
plotedit on, title ('Histogram'), xlabel ('Brightness'),ylabel ('Number'),
plotedit off
pause

disp (' ')
disp ('The most common point operator replaces each pixel by a scaled version of ')
disp ('the original value. We therefore multiply each pixel by a number (like a ')
disp ('gain), by specifying a function scale which is fed the picture and the ')
disp ('gain, or a level shift (upwards or downwards). The function scale takes ')
disp ('a picture pic and multiplies it by a gain - here 1.2 - and adds a level -')
disp ('here 10. After viewing the image press RETURN')
 
%We'll call the function scale.m
brighter=scale(eye,1.2,10);
disp ('Let us see the top left hand corner')
brighter(1:10,1:10)
subplot(2,2,1), imagesc(eye, [mini maxi])
plotedit on, title ('Original image'), plotedit off
subplot(2,2,2), plot(histogram(eye))
plotedit on, title ('Original histogram'), plotedit off
subplot(2,2,3), imagesc(brighter, [mini maxi])
plotedit on, title ('Brighter image'), plotedit off
subplot(2,2,4), plot(histogram(brighter))
plotedit on, title ('Brighter histogram'), plotedit off
pause

mult=input('Now choose a new value for the scale (e.g. 0.8) ');
add=input('And a new value for the offset (e.g. 5) ');
nbrighter=scale(eye,mult,add);
disp ('Now see the result')
subplot(2,2,1), imagesc(eye, [mini maxi])
plotedit on, title ('Original image'), plotedit off
subplot(2,2,2), imagesc(nbrighter, [mini maxi])
plotedit on, title ('New Image'), plotedit off
subplot(2,2,3), imagesc(brighter, [mini maxi])
plotedit on, title ('Brighter image'), plotedit off
subplot(2,2,4), plot(histogram(nbrighter))
plotedit on, title ('New histogram'), plotedit off
pause;

disp (' ')
disp ('We shall now take a mathematical function of an image, here the logarithm')
disp ('This is often used to compress components of the Fourier transform, for display')
disp ('Its effect here is to make the numbers so small, you can see very litte!')
%We'll call the function logn.m
log_eye=log(eye);
log_eye(1:10,1:10)
subplot(1,1,1), image(log_eye);
plotedit on, title ('Logarithm of eye'), plotedit off
pause;

disp (' ')
disp ('For guaranteed viewing, we normalise images to stretch their histogram to ')
disp ('occupy all available grey levels. This is what appears to be what is done by ')
disp ('Matlab s imagesc function')
%We'll call the function normalise.m
norm_eye=normalise(eye);
disp ('Let us see the top left hand corner')
norm_eye(1:10,1:10)
imagesc(norm_eye);
plotedit on, title ('Normalised image'), plotedit off 
pause;
disp ('The histogram of the new image shows how all the grey levels have been used')
hist_norm=histogram(norm_eye);
plot(hist_norm);
plotedit on, title ('Normalised Histogram'), plotedit off 
pause;

disp (' ')
disp ('The display process optimised for human viewing is called histogram equalisation ')
disp ('Here, unlike intensity normalisation, black and white are not given the same weight')
disp ('This stretches image intensity in a manner particularly suited to human viewing')
%We'll call the function equalise
equa_eye=equalise(eye);
equa_eye(1:10,1:10)
imagesc(equa_eye);
plotedit on, title ('Equalised eye'), plotedit off 
pause;
disp ('The histogram of the new image shows how the whole range of grey levels has been used')
equa_hist=histogram(equa_eye);
plot(equa_hist);
plotedit on, title ('Equalised histogram'), plotedit off 
pause;

disp (' ')
disp ('We shall now consider the thresholding function that sets points above a ')
disp ('specified level to white and all others to black. Using a threshold of 161, we get')
%We'll call the function threshold
thre_eye=threshold(eye,160);
thre_eye(1:10,1:10)
imagesc(thre_eye)
plotedit on, title ('Eye thresholded at 160'), plotedit off 
pause;
thresh=input('Now choose a threshold (e.g. 180) ');
nthre_eye=threshold(eye,thresh);
subplot(1,2,1), imagesc(thre_eye)
plotedit on, title ('Image thresholded at 160'), plotedit off
subplot(1,2,2), imagesc(nthre_eye)
plotedit on, title ('Image thresholded at new value'), plotedit off 
disp ('If your threshold was greater than 160, fewer points should be set')
disp ('to white')
pause;

disp (' ')
disp ('We shall now move on to group operators where the new pixel values are the ')
disp ('result of analysing points in a region, rather than point operators which') 
disp ('operate on single points. First, we have a template which describes the region') 
disp ('of interest and we then convolve this by summing up, over the region of the ') 
disp ('template, the result of multiplying  pixel values by the respective template ')
disp ('(weighting) coefficient.')

disp (' ')
disp ('The generalised operator is template convolution, but we shall first look')
disp ('at direct implementation of direct averaging. Here, points in a new image')
disp ('are the average of a 3*3 region, centred at the point of interest, in the')
disp ('old image. The result is shown as an image, and as points.')
%and we'll invoke the function ave33.m
ave33_eye=ave33(eye);
ave33_eye(1:10,1:10)
subplot(1,1,1), imagesc(ave33_eye)
plotedit on, title ('Averaged eye'), plotedit off 
pause;

disp (' ')
disp ('Now we shall use a larger operator, 5*5, using the general function ave')
disp ('This takes a little longer - it has more data to process')
%it's to ave we go
ave55_eye=ave(eye,5);
disp ('There is a greater amount of smoothing with a bigger operator')
disp ('but the noise is much more reduced')
disp ('Notice that the border gets wider as the window size increases. It')
disp ('has been set to black (0) here.')
 ave55_eye(1:10,1:10)
imagesc(ave55_eye);
plotedit on, title ('Eye averaged by 5*5 operator'), plotedit off 
pause;

disp ('The template for this is one where each point is the reciprocal of the ')
disp ('number of points in it')
ave_temp=ave_template(3)
disp ('This can be used within template convolution as shown by an image equalling the earlier result')
ave_eye=template_convolve(eye,ave_temp);
imagesc(ave_eye);
pause;

disp (' ')
disp ('In image processing, we often use a Gaussian smoothing filter which can ')
disp ('give a better smoothing performance than direct averaging. In this the ') 
disp ('template coefficients are set according to the Gaussian distribution. ')
disp ('For a 19*19 template, with variance of 4, this is shown as surface.')
%and the function is gaussian_template
gaussian_temp=Gaussian_template(19,4);
surf(gaussian_temp);
pause;

disp (' ')
disp ('For speed, we often use smaller window sizes in convolution. Here we')
disp ('shall use a 5*5 operator, with variance 0.9, to filter the image.')
disp ('The template coefficients are:')
gauss_temp=Gaussian_template(5,0.9);
gauss_eye=template_convolve(eye,gauss_temp);
imagesc(gauss_eye);
plotedit on, title ('Eye averaged by 5*5 Gaussian operator'), plotedit off 
disp ('Notice how features are better preserved in Gaussian smoothing, but with similar noise reduction to direct averaging')
pause;

disp (' ')
disp ('For speed, it is common to use the Fourier transform when the temple is bigger that 7*7.')
disp ('Essentially we compute the inverse FFT of the transform of the image')
disp ('mutiplied (point by point) by the transfrom of the template.')
disp ('Note that the template has to be padded to be the same size as the image.')
disp (' ')
disp ('For comparison, let s do it the hand-crafted way (without Fourier).')
disp ('We shall do it by Fourier straight after')
gauss_eye=template_convolve(eye,Gaussian_template(11,1.5));
pause;

disp ('Now the Fourier ')
fast_gauss_eye=ifft2(rearrange(fft2(eye).*fft2(pad(eye,Gaussian_template(11,1.5)))));
pause;

disp ('Let us have a look')
brighter(1:10,1:10)
subplot(2,2,1), imagesc(eye)
plotedit on, title ('Original image'), plotedit off
subplot(2,2,2), imagesc(pad(eye,Gaussian_template(19,4.0)))
plotedit on, title ('Padded template'), plotedit off
subplot(2,2,3), imagesc(gauss_eye)
plotedit on, title ('Direct Gaussian averaging'), plotedit off
subplot(2,2,4), imagesc(fast_gauss_eye)
plotedit on, title ('Fourier Gaussian averaging'), plotedit off
pause;
disp ('It is faster, wow! But is it the same?')

disp ('Let us subtract the images to show the differences between them')
subplot(1,1,1), imagesc(fast_gauss_eye-gauss_eye)
disp ('The differences are  in the border, not in the inner region. Why?')

disp ('Let us move on to more smoothing operators. First, we shall use the median')
disp ('operator. We shall start with a new test image')
pause;

rock=imread('rock.png');
rock=double(rock(:,:,1));
colormap(gray);
imagesc(rock)
pause;

disp ('Now we shall add some noise to it')
noisy_rock=add_Gaussian_noise(rock,20);
imagesc(noisy_rock)
pause;

disp('Let us use some Gaussian filtering')
smoothed=template_convolve(noisy_rock,Gaussian_template(5,0.9));
imagesc(smoothed)
pause;

disp('An alternative is the median operator')
smoothed=median(noisy_rock,5);
imagesc(smoothed)
pause;
disp('This preserves the edges more than averaging. It is not actually')
disp('optimal for Gaussian noise, but salt and pepper noise')
disp('Let us see some')

noisy_rock=add_salt_and_pepper(rock,.01);
imagesc(noisy_rock)

disp('Let us use the median operator on it')
smoothed=median(noisy_rock,5);
imagesc(smoothed)
disp('Impressive eh. Sure, but slow.')
pause;

disp('A more modern operator is non local means.')
disp('Let us go back to Gaussian noise')
noisy_rock=add_Gaussian_noise(rock,20);
imagesc(noisy_rock)
pause;

disp('and non local means it')
smoothed=non_local_means(noisy_rock,5,15,0.6);
imagesc(smoothed)
disp('that is indeed good! Is it worth the cost?')
pause;

disp('Let us try bilateral filtering')
smoothed=bilateral_filter(noisy_rock,9,5,1,25);
imagesc(smoothed)
disp('Again, that is indeed good! Again, is it worth the cost?')

