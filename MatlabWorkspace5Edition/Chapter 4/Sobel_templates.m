function Sobel_template = Sobel_templates(winsize)
%For generating Sobel templates
%
%  Usage: [new image] = Sobel_templates(winsize)
%
Sobel_averaging(winsize)=0;
Sobel_differencing(winsize)=0;
Sobel_template(1:winsize,1:winsize,2)=0;
for i=1:winsize
    Sobel_averaging(i)=factorial(winsize-1)/(factorial(winsize-i)*factorial(i-1));
    Sobel_differencing(i)=Sob_Pascal(i-1,winsize-2)-Sob_Pascal(i-2,winsize-2);
end
Sobel_template(1:winsize,1:winsize,1)=transpose(Sobel_averaging)*Sobel_differencing;
Sobel_template(1:winsize,1:winsize,2)=transpose(Sobel_differencing)*Sobel_averaging;
end
