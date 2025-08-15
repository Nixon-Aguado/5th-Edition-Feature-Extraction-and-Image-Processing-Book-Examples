function projection = BackProjection(image, histogram)
% Implementation of BackProjection
% Parameters: Image, histogram and region where to perform the back projection 
%             the size is measured from the centre of the region         

% Colour components
red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

% Image Size
[ imageRows imageColumns depth ] = size(image);

% Create new image
projection(1:imageRows,1:imageColumns) = 0;

% Density estimation
for row = 1 : imageRows           % Image rows
    for column = 1 : imageColumns % Columns inside the image region
        
        % Compute 2D color features (Cb,Cr) for the (x,y) pixel
        [Cb Cr] = ColourFeature(red(row,column), green(row,column), blue(row,column));
        
        % Back project
        projection(row,column) = histogram(int8(Cb),int8(Cr));
    end
end


            