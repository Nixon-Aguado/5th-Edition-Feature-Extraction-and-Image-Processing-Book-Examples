function pic = draw_points(contour,pic)
[rowsc,colsc]=size(contour);
for s=1:rowsc
    pic(contour{s,2},contour{s,1})=255;
end
