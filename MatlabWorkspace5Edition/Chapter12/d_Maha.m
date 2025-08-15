function dist=d_Maha(mat1,mat2)
[rows,cols]=size(mat1);
cov=(covariance(mat1)+covariance(mat2))/2;
dist=1/rows*sqrt(trace((mat1-mat2)*inv(cov)*transpose(mat1-mat2)));