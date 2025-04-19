function histogram = Density(image, s, regionRadious, h)
% Implementation of density estimation for a colour image
% Parameters: Image, Position of the image region, the size of the region and kernel size
%             the size is measured from the centre of the region/kernel         

% Colour components
red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

% Create 64x64 histogram
histSize = 64;
histogram(1:histSize,1:histSize) = 0;

% Total number of values in the histogram for normalisation
total = 0;

% Density estimation
for DeltaRow = -regionRadious(1) : regionRadious(1)        % Rows inside the image region
    for DeltaColumn = -regionRadious(2) : regionRadious(2) % Columns inside the image region
        
        % Position of the pixel in the image
        row = s(1) + DeltaRow;
        column = s(2) + DeltaColumn;
        
        % Compute 2D color features (Cb,Cr) for the (x,y) pixel
        [Cb Cr] = ColourFeature(red(row,column), green(row,column), blue(row,column));
       
        % Gaussian kernel
        w = exp(-(DeltaRow*DeltaRow + DeltaColumn*DeltaColumn)/2*h*h);
        
        %increment histogram
        histogram(int8(Cb),int8(Cr)) = histogram(int8(Cb),int8(Cr))+w;
        total = total + w;
    end
end

% Normailse
histogram = histogram ./ total;
            
            