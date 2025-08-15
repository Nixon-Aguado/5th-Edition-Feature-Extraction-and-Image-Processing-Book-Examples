% Feature Extraction and Image Processing 
% Mark S. Nixon & Alberto S. Aguado

function [image] = inverse_F_transform(Fourier_image)

% New image is the inverse Discrete Fourier Transform (DFT) of  a Fourier image
% Usage: new image = inverse_F_transform(Fourier_image)

image=double(Fourier_image);

[rows, cols] = size(Fourier_image);
%we deploy a form of equation 2.27, so that we can handle non square images
for x=1:cols % along the horizontal axis 
    for y=1:rows % down the vertical axis
        sumu=0;
        for u=1:cols
            %first we transform the rows
            sumv=0;
            for v=1:rows
                sumv=sumv+Fourier_image(v,u)*exp(1j*2*pi*(v-1)*(y-1)/rows);
            end
            %then we do the columns
            sumu=sumu+sumv*exp(1j*2*pi*(u-1)*(x-1)/cols);
        end
        image(y,x) = sumu;
    end
end