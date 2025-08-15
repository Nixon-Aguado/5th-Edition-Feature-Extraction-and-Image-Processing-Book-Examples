function [Cb, Cr] = Colourfeature(red, green, blue)
% Compute colour feature from RGB colour components
% Parameters: Colour components

% Normalise
r = double(red) / 256;
g = double(green) / 256;
b = double(blue) / 256;

% Colour features form 1 to 64
Cb = (128 - 37.79*r - 74.203*g +    112*b)/4;
Cr = (128 +   112*r - 93.786*g - 18.214*b)/4;    
