%% Show Original Picture & Noise
clear all;
close all;
clc;
img = imread('./pic/lena_gray.tif');
imshow(img); title('Original');
[m n] = size(img);
img_n = imnoise(img, 'salt & pepper', 0.2);
figure; imshow(img_n); title('Salt & Pepper Noise 20%');
%% Expand Picture
Nmax = 3;
new_img = zeros(m+2*Nmax, n+2*Nmax);
new_img(Nmax+1:m+Nmax,Nmax+1:n+Nmax) = img_n; % Place in middle

new_img(1:Nmax,Nmax+1:n+Nmax) = img(1:Nmax,1:n); % up alignment
new_img(1:m+Nmax,n+Nmax+1:n+2*Nmax) = new_img(1:m+Nmax,n+1:n+Nmax); % right alignment
new_img(m+Nmax+1:m+2*Nmax,Nmax+1:n+2*Nmax) = new_img(m+1:m+Nmax,Nmax+1:n+2*Nmax); % down alignment
new_img(1:m+2*Nmax,1:Nmax) = new_img(1:m+2*Nmax,Nmax+1:2*Nmax); % left alignment
figure; imshow(uint8(new_img)); title('Expand Boundary');
re = new_img;
%% Adaptive Median Filter
for i = Nmax+1:m+Nmax
    for j = Nmax+1:n+Nmax
        r = 1;
        while r ~= Nmax + 1
            W = new_img(i-r:i+r,j-r:j+r);
            W = sort(W(:));           
            Imin = min(W(:));        
            Imax = max(W(:));         
            Imed = W(ceil((2*r+1)^2/2));      
            if Imin<Imed && Imed<Imax       
               break;
            else
                r = r + 1;              
            end     
        end
        if Imin<new_img(i,j) && new_img(i,j)<Imax
            re(i,j) = new_img(i,j);
        else
            re(i,j) = Imed;
        end
    end
end
figure; imshow(uint8(re(Nmax+1:m+Nmax,Nmax+1:n+Nmax))); title('Adaptive Median Filter'); % size 3~7
%%
medfilt_pepper = medfilt2(img_n, [5 5]);
figure; imshow(medfilt_pepper); title('Median Filter');

