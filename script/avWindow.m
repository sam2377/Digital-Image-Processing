global kernal_size;
global f;
kernal_size = 3;
f = imread('./pic/lena_gray.tif');
imshow(f)
%{
if ndims(f) == 3
    gray_f = rgb2gray(f);
end
figure, imshow(gray_f)
imwrite(gray_f, 'lena_gray.tif');
%}

av_f = zeros(512, 512, 'uint8');
for i = 1:512
    for j = 1:512
        av_f(i, j) = get_avValue(i, j);
    end
end
figure, imshow(av_f)

function v = get_avValue(i, j)
    global kernal_size;
    global f;
    v = uint16(0);
    start_pti = i - floor(kernal_size/2);
    start_ptj = j - floor(kernal_size/2);
    
    for i = 0:kernal_size-1
        for j = 0:kernal_size-1
            if start_pti + i <= 512 && start_pti + i >= 1 && start_ptj + j <= 512 && start_ptj + j >= 1
                v = v + uint16(f(start_pti + i, start_ptj + j));
            end
        end
    end
    
    v = v/(kernal_size * kernal_size);
    v = uint8(v);
end