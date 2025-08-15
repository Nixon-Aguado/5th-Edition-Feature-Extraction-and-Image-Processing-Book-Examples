function newPosition = MeanShift(image, q, s, regionRadious, h)
% Implementation of mean shift
% Parameters: Image, region density, previous position, the size of the region and kernel size

% Colour components
red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

% Create weight matrix
wSize = 2*regionRadious+1;
w(1:wSize,1:wSize) = 0;

% Density in current frame position
qs = Density(image, s, regionRadious, h);

% Compute weights
for DeltaRow = -regionRadious(1) : regionRadious(1)        % Rows inside the image region
    for DeltaColumn = -regionRadious(2) : regionRadious(2) % Columns inside the image region
        
        % Position of the pixel in the image
        row = s(1) + DeltaRow;
        column = s(2) + DeltaColumn;
        
        % Compute 2D color features (Cb,Cr) for the (x,y) pixel
        [Cb Cr] = ColourFeature(red(row,column), green(row,column), blue(row,column));
        
        % Weight index
        wRow = DeltaRow + regionRadious(1) + 1;
        wColumn = DeltaColumn + regionRadious(2) + 1;
        
        % Weight
        if qs(int8(Cb),int8(Cr)) > 0
            w(wRow, wColumn) = ( q(int8(Cb),int8(Cr)) / qs(int8(Cb),int8(Cr)) );
        end

    end
end

% Compute mean shift sumations
meanSum = 0;
kernelSum = 0;
for DeltaRow = -regionRadious(1) : regionRadious(1)        % Rows inside the image region
    for DeltaColumn = -regionRadious(2) : regionRadious(2) % Columns inside the image region
        
         % Kernel parameter 
        a = (DeltaRow*DeltaRow + DeltaColumn*DeltaColumn) / h*h;
        
        % Gaussian kernel
        g = exp(-(a)/2);
        
        % Weight index
        wRow = DeltaRow + regionRadious(1) + 1;
        wColumn = DeltaColumn + regionRadious(2) + 1;
        
        % Position of the pixel in the image
        row = s(1) + DeltaRow;
        column = s(2) + DeltaColumn;
        
        % Mean sum
        meanSum = meanSum +  g * w(wRow, wColumn) * [row column];
        
        % Kernel sum
        kernelSum = kernelSum +  g * w(wRow, wColumn);
        
    end    
end

% Mean shift 
newPosition = round(meanSum / kernelSum);

          
            