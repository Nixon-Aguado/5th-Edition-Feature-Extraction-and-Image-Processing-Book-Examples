%Chapter 6 Deformable shape analysis

disp ('Welcome to the Chapter 6 script')
disp ('This worksheet is the companion to Chapter 6.')
disp ('The worksheet so far has a Greedy snake and the Discrete Symmetry transform')
disp ('We have the code for the Kass snake and can add it if asked')

%Let's initialise the display colour
colormap(gray);

%And let's start with empty memory
clear

eye=imread('eye_orig','jpg');
eye=double(eye(:,:,1));
colormap(gray)
edges=Sobel_mag(eye); %get edge magnitude
norm_edges=edg_normalise(edges); %normalise it (to balance forces)
initial_contour=points(9,30,41,31); %specify original contour
a=draw_points(initial_contour,eye); %let's have a peep at the contour
imagesc(a)
new_contour1=grdy(norm_edges,initial_contour);
new_contour2=grdy(norm_edges,new_contour1);
new_contour3=grdy(norm_edges,new_contour2);
new_contour4=grdy(norm_edges,new_contour3);
new_contour5=grdy(norm_edges,new_contour4);
new_contour6=grdy(norm_edges,new_contour5);
new_contour7=grdy(norm_edges,new_contour6);
new_contour8=grdy(norm_edges,new_contour7);
new_contour9=grdy(norm_edges,new_contour8);
new_contour10=grdy(norm_edges,new_contour9);
new_contour11=grdy(norm_edges,new_contour10);
new_contour12=grdy(norm_edges,new_contour11);
new_contour13=grdy(norm_edges,new_contour12);
new_contour14=grdy(norm_edges,new_contour13);
subplot(2,2,1), imagesc(draw_points(initial_contour,eye))
plotedit on, title ('initial_contour'), plotedit off
subplot(2,2,2), imagesc(draw_points(new_contour1,eye))
plotedit on, title ('1st iteration'), plotedit off
subplot(2,2,3), imagesc(draw_points(new_contour6,eye))
plotedit on, title ('6th iteration'), plotedit off
subplot(2,2,4), imagesc(draw_points(new_contour14,eye))
plotedit on, title ('14th iteration'), plotedit off
pause
%you'll have to do a lot of imagescs to see all of these!

disp ('Let us have a look at the DST. Note it is slow with large values of sigma')
%Let's try a sigma of 0.8
symmetry_eye1=DST(eye,1,Sobel_log(eye));
%Let's try a sigma of 10
symmetry_eye2=DST(eye,10,Sobel_log(eye));
subplot(1,2,1), imagesc(symmetry_eye1)
plotedit on, title ('Local symmetry'), plotedit off
subplot(1,2,2), imagesc(symmetry_eye2)
plotedit on, title ('Global symmetry'), plotedit off

