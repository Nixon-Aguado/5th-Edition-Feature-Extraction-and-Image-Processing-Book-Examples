function edg = edg_normalise(edg)
% Normalise edge image
%
% Usage: normalise edge image = edg_normalise(edge image, contour_points)
               
[rows,cols]=size(edg);
offset=min(min(edg));
scale=1/(max(max(edg))-min(min(edg)));
for x=1:cols
    for y=1:rows
        edg(y,x)=1-((edg(y,x)-offset)*scale);
    end
end

