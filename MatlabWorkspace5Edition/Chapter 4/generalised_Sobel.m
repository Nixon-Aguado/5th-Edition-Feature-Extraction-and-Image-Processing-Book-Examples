function edge = generalised_Sobel(image, winsize)
%New image point brightness = magnitude of Prewitt operator
%
%  Usage: [new image] = mag_Prewitt(image)
%
%  Parameters: images of magnitude and phase      - arrays of points

%get dimensions
[rows,cols]=size(image);

%set the output image to black (0)
edge(1:rows,1:cols,2)=0;

%generate the templates
templates=Sobel_templates(winsize);
mx=templates(:,:,1);
my=templates(:,:,2);

%then apply the operator
Sobel_y=template_convolve(image,my);
Sobel_x=template_convolve(image,mx);

border=floor(winsize/2);
for x = border:cols-border %address all columns except border
  for y = border:rows-border %address all rows except border
      %magnitude
      edge(y,x,1)=floor(sqrt(Sobel_x(y,x)*Sobel_x(y,x)+...
                              Sobel_y(y,x)*Sobel_y(y,x)));
      %direction
      edge(y,x,2)=floor(sqrt((atan(Sobel_y(y,x)/...
                              Sobel_x(y,x))+(pi/2))*180/pi));
  end
end