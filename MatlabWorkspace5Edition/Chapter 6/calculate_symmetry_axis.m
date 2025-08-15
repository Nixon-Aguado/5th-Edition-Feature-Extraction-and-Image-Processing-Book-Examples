eye=imread('insect.jpg');
%images are stored as integers, so we need to double them for Matlab
%we also need to ensure we have a greyscale, not three colour planes 
eye=double(eye(:,:,1));
colormap(gray);
a=template_convolve(eye,LoG_template(55,9));
b=zero_cross(a);
imagesc(b);
c=Sobel_log(eye);
c(:,:,1)=c(:,:,1).*b;
e=DST(eye,25,c);
f(:,:,3)=template_convolve(e,Gaussian_template(25,5));
f(:,:,1)=c(:,:,1);
f(:,:,2)=c(:,:,2);
g=non_max_supp(f);
g=normalise(g);
thresholded_peaks = hyst_thr(g,120,60);
imagesc(thresholded_peaks);
thresholded_peaks = threshold(g,120);
eye=imread('insect.jpg');
sym_axis_eye(:,:,1:3)=0;
sym_axis_eye(:,:,1)=eye(:,:,1)+uint8(thresholded_peaks);
sym_axis_eye(:,:,2)=eye(:,:,2)+uint8(thresholded_peaks);
sym_axis_eye(:,:,3)=eye(:,:,3)+uint8(thresholded_peaks);
imagesc(sym_axis_eye);
