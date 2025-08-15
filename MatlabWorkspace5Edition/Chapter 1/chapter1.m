%Chapter 1 Introduction (Hello Matlab) CHAPTER1.M

clear %We shall empty all memory and settings to start

disp ('Welcome to the Chapter1 script')
disp ('This worksheet is the companion to Chapter 1 and is an introduction.')
disp ('It is the source of Section 1.5.4 Hello Matlab.')
disp ('The worksheet follows the text directly and allows you to process basic images.')

%Time to read in an image
pic=imread('Square.png'); 

%Let's see what we have
imagesc(pic); %view image

%now view it in black and white
disp ('We shall  display the data as a grey level image')
colormap(gray);

% Let's hold so we can view it
disp ('When you are ready to move on, press RETURN')
pause;

%Pixels are addressed in row-column format. 
%Using x for the horizontal axis (a column count), and y for the vertical axis (a row count)
% then picture points are addressed as pic(y,x). The origin is at co-ordinates (1,1), so 
% the point pic(3,3) is on the third row and third column; the point pic(4,3) is on the 
% fourth row, at the third column.  Let's print them:
disp ('The element pic(3,3) is')
pic(3,3)
disp ('The element pic(4,3) is')
pic(4,3)

%We can view the matrix as a surface plot
disp ('We shall now view the array as a surface plot - as a figure (play with the controls to see it in relief)')
disp ('When you are ready to move on, press RETURN')
bar3(pic);
%Let's hold awhile so we can view it
pause;
%Or as an image
disp ('We shall now view the array as an image')
disp ('When you are ready to move on, press RETURN')
imagesc(pic);
%Let's hold awhile so we can view it
pause;

%Let's look at its dimensions
disp ('The dimensions of the array are')
size(pic)

%now let's invoke a routine that inverts the image
inverted_pic = invert(pic);
%Let's print it out to check it
disp ('When we invert it by subtracting each point from the maximum, we get')
inverted_pic
%And view it
disp ('And when viewed as an image, we see')
disp ('When you are ready to move on, press RETURN')
imagesc(inverted_pic);
%Let's hold awhile so we can view it
pause;

disp ('We shall now read in a bitmap image, and view it')
disp ('When you are ready to move on, press RETURN')
pic=imread('Zebra.png');
imagesc(pic);
pause;

%We need to change from unsigned integer format (uint8) to double precision so we can process it
pic=double(pic);

disp ('Now we shall invert it, and view the inverted image')
inverted_pic=invert(pic);
imagesc(inverted_pic);
disp ('So we now know how to process images in Matlab. We shall be using this later!')






