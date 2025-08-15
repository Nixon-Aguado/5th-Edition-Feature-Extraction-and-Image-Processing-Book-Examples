function cov=covariance(matrix)
[rows,cols]=size(matrix);
cov=1/rows*transpose(subtract_mean(matrix))*subtract_mean(matrix);