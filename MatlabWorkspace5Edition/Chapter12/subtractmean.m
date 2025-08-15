function a_colmean=subtract_mean(matrix)

[rows,cols]=size(matrix);
a_colmean(1:cols,1:rows)=0;
for j=1:rows
    for i=1:cols
        a_colmean(j,i)=matrix(j,i)-mean(matrix(:,i));
    end
end