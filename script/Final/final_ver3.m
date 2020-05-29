%% Show pic
clear;
clc;
close all;
img_origin = imread('NCKU2_n20.jpg');
I = imread('Section1.jpg');
imshow(I), title('Origin Pic');
%% Otsu
level = graythresh(I);
BW2 = im2bw(I, level);
figure, imshow(BW2), title('Otsu');
%% Open
SE = strel('octagon', 6);
Openbw = imopen(~BW2, SE);
figure, imshow(Openbw), title('Open');
%% Fill hole
Fillbw = imfill(Openbw, 'holes');
figure, imshow(Fillbw), title('Fill');
%% Hyperparameters
upperbound = 30000;
lowerbound = 1000;
local_open_bound = 12000;
%%
stats = regionprops(Fillbw, 'BoundingBox', 'Area', 'Centroid', 'Image', 'PixelList');
for i = 1:size(stats)
    area = stats(i).Area;
    if area > local_open_bound
        img = stats(i).Image;
        SE = strel('diamond', 10);
        img = imopen(img, SE);
        % figure, imshow(img);
        
        col = stats(i).BoundingBox(1) + 0.5;
        row = stats(i).BoundingBox(2) + 0.5;
        width = stats(i).BoundingBox(3);
        height = stats(i).BoundingBox(4);
        
        list = stats(i).PixelList;
        for k = 1:size(list)
            idx = list(k, 1);
            idy = list(k, 2);
            Fillbw(idy, idx) = img(idy-row+1, idx-col+1);
        end
    end
end
figure, imshow(Fillbw), title('Local Open');
%%
sum = 0;
stats = regionprops(Fillbw, 'BoundingBox', 'Area', 'Centroid', 'Image', 'PixelList');
centroids = cat(1, stats.Centroid);
figure, imshow(img_origin), title('FF');
hold on
for i = 1:size(stats)
    area = stats(i).Area;
    if area > lowerbound && area < upperbound
        rectangle('Position',[stats(i).BoundingBox],'LineWidth', 1.5,'LineStyle','-','EdgeColor','r'),
        plot(centroids(i,1), centroids(i,2), 'b*');
        sum = sum + 1;
    end
end
hold off

fprintf('Total Counts: %d\n', sum);
