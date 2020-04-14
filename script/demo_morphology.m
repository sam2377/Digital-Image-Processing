%% Save Binary Image
I = imread('./pic/lena_gray.tif');
IB = im2bw(I, 0.5);
IB2 = imbinarize(I);
figure('Name', 'Binary Image', 'NumberTitle','off')
subplot(1,3,1), imshow(I), title('origin');
subplot(1,3,2), imshow(IB), title('im2bw');
subplot(1,3,3), imshow(IB2), title('imbinarize with Otsu');
imwrite(IB, './pic/lena_bin.tif');

%% Morphology Operation on Binary Image
figure, imshow(IB);
figure('Name', 'Morphology Operation Binary', 'NumberTitle','off');
kernel = ones(5);
kernel(1,1) = 0; kernel(1,5) = 0; kernel(5,1) = 0; kernel(5,5) = 0; 
I_ER = imerode(IB, kernel);
subplot(2,2,1), imshow(I_ER), title('Erosion');
I_DI = imdilate(IB, kernel);
subplot(2,2,2), imshow(I_DI), title('Dilation');
I_OP = imopen(IB, kernel);
subplot(2,2,3), imshow(I_OP), title('Open');
I_CL = imclose(IB, kernel);
subplot(2,2,4), imshow(I_CL), title('Close');
%% Morphology Operation on Gray-level Image
figure('Name', 'Morphology Operation Gray-level', 'NumberTitle','off');
I_ER = imerode(I, kernel);
subplot(2,2,1), imshow(I_ER), title('Erosion');
I_DI = imdilate(I, kernel);
subplot(2,2,2), imshow(I_DI), title('Dilation');
I_OP = imopen(I, kernel);
subplot(2,2,3), imshow(I_OP), title('Open');
I_CL = imclose(I, kernel);
subplot(2,2,4), imshow(I_CL), title('Close');

