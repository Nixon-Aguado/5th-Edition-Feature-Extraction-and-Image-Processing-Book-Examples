%Chapter 5 Fixed shape matching

disp ('Welcome to the Chapter5 script')
disp ('This worksheet is the companion to Chapter 5.')
disp ('Here you will find template matching and the basic Hough transform functions')

disp ('Here is an image.')
eye=imread('eye','jpg');
imagesc(eye(:,:,1))
disp ('Hit return to continue')
pause
disp ('And here is its edge detected version.')
sob_eye=Sobel(eye);
imagesc(sob_eye(:,:,1))
disp ('Hit return to continue')
pause

%define circle template
xcentre=60;
ycentre=50;
radius=48;
b=draw_full_circle(eye,xcentre,ycentre,radius);
c=b(ycentre-radius:ycentre+radius,xcentre-radius:xcentre+radius);

disp ('First, we shall do it by template matching')
d=template_match(sob_eye(:,:,1),c);
imagesc(d)
disp ('That is pretty good, eh!')
disp ('Hit return to continue')
pause

disp ('Now we shall do template matching by Fourier')
e=template_match_Fourier(sob_eye(:,:,1),c);
imagesc(e)
disp ('That is just the same, and it was quicker.')
disp ('Hit return to continue')
pause

disp ('Now we find lines by the Hough transform, so wait...')
lizard=imread('lizardsmall.png');
lizard=double(lizard(:,:,1));
newlizard=line_hough(lizard);
%that line looks good eh!
%let's have a look
edges=Sobel(lizard);
subplot(1,2,1), imagesc(edges(:,:,1))
plotedit on, title ('Edge detected version'), plotedit off
subplot(1,2,2), imagesc(newlizard)
plotedit on, title ('Detected line'), plotedit off
pause


disp ('Now we shall do it by the Hough transform for circles, so wait...')
a=circle_hough(sob_eye(:,:,1),20);
imagesc(a);
disp ('That is the centre.')
disp ('Hit return to continue')
pause

%Hough transform for ellipses, but with fixed values a and b
disp ('Now we shall do it by the Hough transform for ellipses, so wait again...')
a=ellipse_hough(sob_eye(:,:,1),48,45);
imagesc(a)
%good result though!!
disp ('Now you can see why they use the Hough transform for iris detection.')
disp ('Hit return to continue')
pause