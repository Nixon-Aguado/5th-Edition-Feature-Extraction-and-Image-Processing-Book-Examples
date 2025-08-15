% Feature Extraction and Image Processing 
% Mark S. Nixon & Alberto S. Aguado

function [Fourier] = new_F_transform(image)

% New image is Discrete Fourier Transform (DFT) of image
% Usage: new image = new_F_transform(image)

image=double(image);
[rows, cols] = size(image);
Fourier(1:rows,1:cols)=0;

%we deploy equation 2.27, so that we can handle non square images

for u=1:cols % along the horizontal axis 
        %first we transform the rows
        sumy=0;
        for y=1:rows
            sumy=sumy+image(y,u)*exp(-1j*2*pi*(v*y)/rows);
        end
        Fourier(v,u)=sumy;
end
for v=1:rows % down the vertical axis
        %then we transpose the columns
        sumx=0;
        for x=1:cols
            sumx=sumx+Fourier(v,x)*exp(-1j*2*pi*(u*x)/cols);
        end
        Fourier(v,u) = sumx/sqrt(rows*cols);
end
