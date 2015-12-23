clear all
close all
I = imread('IMG_0600.JPG');
B = find(I<100);
I(B) = 0;
imwrite(B,'imgout.jpg');