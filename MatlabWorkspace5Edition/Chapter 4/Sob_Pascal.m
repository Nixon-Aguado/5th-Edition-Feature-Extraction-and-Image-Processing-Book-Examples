function Pascal_coeff = Sob_Pascal(k,n)
%For generating Pascals triangle coefficients
%
%  Usage: [new image] = Sob_Pascal(k,n)
%
if (k>=0)&(k<=n)
    Pascal_coeff=factorial(n)/(factorial(n-k)*factorial(k));
else
    Pascal_coeff=0;
end