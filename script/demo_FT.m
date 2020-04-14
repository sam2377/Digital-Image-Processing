%% Show Original Picture & Noise
clear all;
close all;
clc;
img = imread('./pic/lena_gray.tif');
[nx, ny] = size(img);
imshow(img); title('Original');
%% Compute FFT
dctSeries = fft2(img);
F = log(abs(fftshift(dctSeries)) + 1);
figure, imshow(F, []);
%% Zero out all small coefficients and inverse transform
for thresh = 0.1*[0.001 0.005 0.01] * max(max(abs(dctSeries)))
    ind = abs(dctSeries) > thresh;
    count = nx*ny - sum(sum(ind));
    dctLow = dctSeries.*ind;
    percent = 100 - count/(nx*ny)*100;
    dLow = uint8(ifft2(dctLow));
    figure, imshow(dLow); title([num2str(percent) '% of FFT basis']);
end
%% high pass
[x, y] = meshgrid(-256:255, -256:255);
z = sqrt(x.^2 + y.^2);
c = z > 200;
H = dctSeries.*c;
figure, imshow(log(abs(H) + 1), []);
qq = uint8(ifft2(H));
figure, imshow(qq);




