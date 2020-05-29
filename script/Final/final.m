%% Show pic
clear;
clc;
I = imread('NCKU2_n20.jpg');
imshow(I), title('Origin Pic');
%% Parameter 
kernel_size = 5;
radius_kernel = fspecial('disk', kernel_size);
sigma = 0.5;
%% Show Output
Wiener_pic = wiener2(I, [kernel_size kernel_size]);
Box_pic = imfilter(I, radius_kernel, 'replicate');
Meadian_pic = medfilt2(I, [kernel_size kernel_size]);
Gaussian_pic = imgaussfilt(I, sigma);
figure, imshow(Wiener_pic), title('Wiener Filter'), 
figure, imshow(Box_pic), title('Box Filter');
figure, imshow(Meadian_pic), title('Meadian Filter');
figure, imshow(Gaussian_pic), title('Gaussian Filter');
%% Test
for i = 1:10
    kernel_size = i;
    Wiener_pic = wiener2(I, [kernel_size kernel_size]);
    Box_pic = imfilter(I, radius_kernel, 'replicate');
    Meadian_pic = medfilt2(I, [kernel_size kernel_size]);
    Gaussian_pic = imgaussfilt(I, sigma);
    figure, imshow(Wiener_pic), title('Wiener Filter'), 
    figure, imshow(Box_pic), title('Box Filter');
    figure, imshow(Meadian_pic), title('Meadian Filter');
    figure, imshow(Gaussian_pic), title('Gaussian Filter');
end
%% Top-Left Blur
sig = 0.5;
alpha = 0.4;
LocalLap_pic = locallapfilt(Meadian_pic, sig, alpha);
figure, imshowpair(Meadian_pic, LocalLap_pic, 'montage')
%% 
imwrite(LocalLap_pic, 'Section1.jpg');