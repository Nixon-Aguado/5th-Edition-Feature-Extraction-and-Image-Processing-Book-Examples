function newImage = DrawSquare(image, s, radious, colour)
% Draw a squre in an image
% Parameters: Image, position, size
%             the size is measured from the centre of the region         

newImage = image;

pixelValue = [ colour colour colour ];

% Draw vertical lime
for DeltaRow = s(1)-radious(1) : s(1)+radious(1)     
    newImage(DeltaRow,s(2)-radious(2),:) = pixelValue;
    newImage(DeltaRow,s(2)+radious(2),:) = pixelValue;
end

% Draw horizontal lime
for Deltacolumn = s(2)-radious(2) : s(2)+radious(2)     
    newImage(s(1)-radious(1),Deltacolumn,:) = pixelValue;
    newImage(s(1)+radious(1),Deltacolumn,:) = pixelValue;
end
            
            