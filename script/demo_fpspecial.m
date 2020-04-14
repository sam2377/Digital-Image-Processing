%%
clc, clear;
w = fspecial('laplacian', 0);

f = imread('./pic/moon.tif');
subplot(2,3,1), imshow(f);
g1 = imfilter(f,w,'replicate');
subplot(2,3,2), imshow(g1,[ ]);

f2 = tofloat(f);
g2 = imfilter(f2,w,'replicate');
 
g = f2 - g2;
subplot(2,3,3), imshow(g);

%%
f = imread('./pic/moon.tif');
w4 = fspecial('laplacian', 0);
w8 = [1 1 1;1 -8 1;1 1 1];
f = tofloat(f);
g4 = f - imfilter(f,w4,'replicate');
g8 = f - imfilter(f,w8,'replicate');
subplot(2,3,4), imshow(f);
subplot(2,3,5), imshow(g4);
subplot(2,3,6), imshow(g8);
