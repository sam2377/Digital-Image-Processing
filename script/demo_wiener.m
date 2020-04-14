%% Weiner Filter
I = imread('./pic/lena_gray.tif');
% imshow(I)
N_guassian = imnoise(I, 'gaussian', 0, 0.005);
figure, imshow(N_guassian), title('Guassian Noise');

K = wiener2(N_guassian, [5 5]);
H = fspecial('disk', 5);
blurred = imfilter(N_guassian, H, 'replicate');
figure, imshow(K),title('Wiener Filter'), figure, imshow(blurred), title('Box Filter');