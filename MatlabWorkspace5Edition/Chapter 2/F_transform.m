% Feature Extraction and Image Processing 
% Mark S. Nixon & Alberto S. Aguado

function [Fourier] = F_transform(image)

% New image is Discrete Fourier Transform (DFT) of image
% Usage: new image = F_transform(image)

image=double(image);
[rows, cols] = size(image);
%we deploy equation 2.27, so that we can handle non square images
for u=1:cols % along the horizontal axis 
    for v=1:rows % down the vertical axis
        sumx=0;
        for x=1:cols
            %first we transform the rows
            sumy=0;
            for y=1:rows %Eq 2.27 inner bracket
                sumy=sumy+image(y,x)*exp(-1j*2*pi*(v-1)*(y-1)/rows);
            end
            %then we do the columns Eq 2.27 outer 
            sumx=sumx+sumy*exp(-1j*2*pi*(u-1)*(x-1)/cols);
        end %and finally normalise
        Fourier(v,u) = sumx/(rows*cols);
    end
end
