function [Crow, Ccolumn, Srow, Scolumn] = ComputeScale(image, s, regionRadious, scaleResult)
% Estimte a scale based on momentos
% Parameters: Single valued image, Position of the image region, the size of the region and a final scale
%             the size is measured from the centre of the region         

% Image Size
[ imageRows imageColumns ] = size(image);

% Momemtus
M00 = 0;
M10 = 0;
M01 = 0;
M11 = 0;
M20 = 0;
M02 = 0;
for DeltaRow = -regionRadious(1) : regionRadious(1)        % Rows inside the image region
    for DeltaColumn = -regionRadious(2) : regionRadious(2) % Columns inside the image region
        
        % Position of the pixel in the image
        row = s(1) + DeltaRow;
        column = s(2) + DeltaColumn;
        
        if row > 0 & row < imageRows & column > 0 & column < imageColumns
            M00 = M00 + image(row,column);
            M10 = M10 + row * image(row,column);
            M01 = M01 + column * image(row,column);
            M11 = M11 + row * column * image(row,column);
            M20 = M20 + row * row * image(row,column);
            M02 = M02 + column* column * image(row,column);
        end
    end
end

Ccolumn = (M01/M00);
Crow = (M10/M00);

a = M20/M00- Crow*Crow;
b = 2*(M11/M00 - Crow *Ccolumn);
c = M02/M00- Ccolumn*Ccolumn;

Srow = round(scaleResult(1) * sqrt((a+c+sqrt(b*b+(a-c)*(a-c))/2)));
Scolumn = round(scaleResult(2) * sqrt((a+c-sqrt(b*b+(a-c)*(a-c))/2)));

Ccolumn = round(M01/M00);
Crow = round(M10/M00);

            