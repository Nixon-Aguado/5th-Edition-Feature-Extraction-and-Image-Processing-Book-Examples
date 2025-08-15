function a_colmean=subtract_mean(matrix)

[rows,cols]=size(matrix);
%a_colmean(1:rows,1:cols)=0;
for i=1:cols
    for j=1:rows
            a_colmean(j,i)=matrix(j,i)-mean(matrix(:,i));
    end
end