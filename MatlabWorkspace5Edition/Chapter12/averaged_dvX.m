function distance=averaged_dvX(mat1,mat2) %evaluate Euclidean distance

[rows,cols]=size(mat1);
distance=0;
for i=1:rows %for all vector elements
    distance=distance+chi2(mat1(i,:),mat2(i,:));
end
distance=distance/rows;