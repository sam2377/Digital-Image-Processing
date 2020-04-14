I = imread('./pic/lena_gray.tif');
I = im2double(I);
D = dctmtx(8);
C = blkproc(I, [8,8], 'P1*x*P2', D, D');
mask1=[1 1 1 1 1 0 0 0
1 1 1 1 0 0 0 0
1 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0];
mask2=[1 1 1 1 0 0 0 0
1 1 1 0 0 0 0 0
1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0];
mask3=[1 1 0 0 0 0 0 0
1 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0];

X = blkproc(C, [8,8], 'P1.*x', mask1);
I1  = blkproc(X, [8,8], 'P1*x*P2', D', D);
X2 = blkproc(C, [8,8], 'P1.*x', mask2);
I2  = blkproc(X2, [8,8], 'P1*x*P2', D', D);
X3 = blkproc(C, [8,8], 'P1.*x', mask3);
I3  = blkproc(X3, [8,8], 'P1*x*P2', D', D);
subplot(1,4,1), imshow(I), title('origin');
subplot(1,4,2), imshow(I1), title('mask 5');
subplot(1,4,3), imshow(I2), title('mask 4');
subplot(1,4,4), imshow(I3), title('mask 2');