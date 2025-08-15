function image = flipxy(image)

%get dimensions
[rows,cols]=size(image);

image(1:cols,1:rows)=image(rows:1:-1,cols:1:-1);

