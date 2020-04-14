I = imread('./pic/lena_gray.tif');
N_guassian = imnoise(I, 'gaussian');
N_pepper = imnoise(I, 'salt & pepper', 0.1);
%{
imwrite(N_guassian, 'lena_guassian_noise.tif');
imwrite(N_pepper, 'lena_pepper_noise.tif');
%}

%% Origin data
subplot(1,3,1), imshow(I), title('origin');
subplot(1,3,2), imshow(N_guassian), title('guassian noise');
subplot(1,3,3), imshow(N_pepper), title('pepper noise');
%% Median Filter
medfilt_origin = medfilt2(I, [3 3]);
medfilt_gussian = medfilt2(N_guassian, [3 3]);
medfilt_pepper = medfilt2(N_pepper, [3 3]);
figure('Name', '3x3 Median Filter', 'NumberTitle','off');
subplot(1,3,1), imshow(medfilt_origin), title('origin');
subplot(1,3,2), imshow(medfilt_gussian), title('guassian noise');
subplot(1,3,3), imshow(medfilt_pepper), title('pepper noise');
%% Box Filter
boxfilt_origin = imboxfilt(I, 3);
boxfilt_gussian = imboxfilt(N_guassian, 3);
boxfilt_pepper = imboxfilt(N_pepper, 3);
figure('Name', '3x3 Box Filter', 'NumberTitle','off');
subplot(1,3,1), imshow(boxfilt_origin), title('origin');
subplot(1,3,2), imshow(boxfilt_gussian), title('guassian noise');
subplot(1,3,3), imshow(boxfilt_pepper), title('pepper noise');
%% PSNR, SNR
[peaksnr, snr] = psnr(medfilt_origin, I);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);
fprintf('\n The SNR value is %0.4f \n', snr);