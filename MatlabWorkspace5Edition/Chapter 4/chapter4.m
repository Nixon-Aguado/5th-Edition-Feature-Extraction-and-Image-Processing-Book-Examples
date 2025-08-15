%Chapter 4 Low level feature extraction (including edge detection)

disp ('Welcome to the Chapter 4 script')
disp ('This worksheet is the companion to Chapter 4 and is an introduction.')
disp ('The worksheet follows the text directly and allows you to process basic images.')
disp ('There is a lot more software in the directory, which is yet to be included here.')

%Let's initialise the display colour
colormap(gray);

%And let's start with empty memory
clear

disp (' ')
disp ('Let us use an image.')
%if you want the eye it's
eye=imread('eye_orig.jpg');
%images are stored as integers, so we need to double them for Matlab
%we also need to ensure we have a greyscale, not three colour planes 
eye=double(eye(:,:,1));
colormap(gray);

disp('Edge detection is differentiation, which is approximated by differencing. Horizontal differencing detects vertical edges where the brightness changes')
deye=horizontal_difference(eye);
subplot(1,2,1), imagesc(eye);
plotedit on, title ('Original eye'), plotedit off
subplot(1,2,2), imagesc(deye);
plotedit on, title ('after horizontal edge detection'), plotedit off
disp ('When you are ready to move on, press RETURN') 
pause;
disp('Vertical differencing detects horizontal edges where the brightness changes')
deye=vertical_difference(eye);
subplot(1,2,1), imagesc(eye);
plotedit on, title ('Original eye'), plotedit off
subplot(1,2,2), imagesc(deye);
plotedit on, title ('after vertical edge detection'), plotedit off
disp ('When you are ready to move on, press RETURN') 
pause;
disp('The basic differencing operator detects horizontal and vertical edges .... and noise')
deye=basic_difference(eye);
subplot(1,2,1), imagesc(eye);
plotedit on, title ('Original eye'), plotedit off
subplot(1,2,2), imagesc(deye);
plotedit on, title ('after basic edge detection'), plotedit off
disp ('When you are ready to move on, press RETURN') 
pause;
disp('To remove noise, we need averaging. Step up the Prewitt operator and that gives magnitude and phase.')
Prewitt_eye=Prewitt(eye);
subplot(2,2,1), imagesc(eye);
plotedit on, title ('Original eye'), plotedit off
subplot(2,2,2), imagesc(deye);
plotedit on, title ('after basic edge detection'), plotedit off
subplot(2,2,3), imagesc(Prewitt_eye(:,:,2));
plotedit on, title ('Prewitt phase (black =0. white = 180)'), plotedit off
subplot(2,2,4), imagesc(Prewitt_eye(:,:,1));
plotedit on, title ('Prewitt magnitude'), plotedit off
disp ('When you are ready to move on, press RETURN')
pause;
disp('That phase is whacky eh! We shall be more careful when we use it later. For now, vectors would be better.')
disp('Let us now see the most famour edge detector, enter the Sobel operator.')
Sobel_eye=Sobel(eye);
subplot(2,2,1), imagesc(eye);
plotedit on, title ('Original eye'), plotedit off
subplot(2,2,2), imagesc(deye);
plotedit on, title ('after basic edge detection'), plotedit off
subplot(2,2,3), imagesc(Sobel_eye(:,:,2));
plotedit on, title ('Sobel phase (black =0. white = 180)'), plotedit off
subplot(2,2,4), imagesc(Sobel_eye(:,:,1));
plotedit on, title ('Sobel magnitude'), plotedit off
disp ('When you are ready to move on, press RETURN')
pause;
disp('It does not look much better than Prewitt, but it has proved so over 60 years!')

disp('Now let us use the generalised Sobel operator, here is a 9*9 operator')
edges=generalised_Sobel(eye,9);

subplot(1,2,1), imagesc(eye);
plotedit on, title ('Original eye'), plotedit off
subplot(1,2,2), imagesc(edges(:,:,1));
plotedit on, title ('after 9*9 Sobel'), plotedit off
pause

disp('Alons y Monsieur Canny')
a=template_convolve(eye,Gaussian_template(5,0.7));
peakySobel=non_max_supp(Sobel_edges(a));
thresholded_peaks = hyst_thr(peakySobel,50,5);
imagesc(thresholded_peaks);
disp('Try changing the upper and lower thresholds to see the detection of features and noise, respectively')
pause

disp('We shall compare Canny with Sobel')
eye=imread('lizardverysmall.png');
eye=double(eye(:,:,1));
colormap(gray);
imagesc(eye)
a=template_convolve(eye,Gaussian_template(5,.7));
imagesc(a)
peakySobel=non_max_supp(Sobel_edges(a));
peakySobel=normalise(peakySobel);
thresholded_peaks = hyst_thr(peakySobel,40,5);
thresholded_peaks=threshold(thresholded_peaks,200);
b=Sobel(a);
c=threshold(b(:,:,1),110);
subplot(1,2,1), imagesc(thresholded_peaks);
plotedit on, title ('Result via Canny'), plotedit off
subplot(1,2,2), imagesc(c);
plotedit on, title ('Result via Sobel'), plotedit off
pause

disp('Step up Marr Hildreth')
a=template_convolve(eye,LoG_template(19,3));
b=zero_cross(a);
image(b)
disp('Try different values of the template size and variance. Note that the contours are connected.')
disp ('When you are ready to move on, press RETURN')
pause;

disp('Give context aware saliency a go!')
eye=imread('lizardverysmall_colour.png');
disp('Note that this takes a while...')
cas = context_aware_saliency(eye,7,10);
imagesc(cas)
disp('Try different values for patch_size and searchsize (but not big ones unless you are off for dinner)')




