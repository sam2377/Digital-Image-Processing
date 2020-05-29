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
%%
SE = strel('octagon', 6);
Openbw = imopen(~BW2, SE);
figure, imshow(Openbw), title('Open');
%%
Fillbw = imfill(Openbw, 'holes');
figure, imshow(Fillbw), title('Fill');
%%
SE = strel('square', 4);
Erodebw = imerode(Fillbw, SE);
figure, imshow(Erodebw), title('Erode');
%%
arr = [1 1 1 1 1 1 1 1 1
       1 1 1 1 1 1 1 1 1
       1 1 1 1 1 1 1 1 1
       0 0 0 1 1 1 0 0 0
       0 0 0 1 1 1 0 0 0
       0 0 0 1 1 1 0 0 0
       1 1 1 1 1 1 1 1 1
       1 1 1 1 1 1 1 1 1
       1 1 1 1 1 1 1 1 1
    ];
SE = strel(arr);
Openbw = imopen(Erodebw, SE);
figure, imshow(Openbw), title('Open I');
%%
upperbound = 30000;
lowerbound = 1000;
%%
stats = regionprops(Openbw, 'BoundingBox', 'Area', 'Centroid', 'Image', 'PixelList');
for i = 1:size(stats)
    area = stats(i).Area;
    if area > 12000
        img = stats(i).Image;
        SE = strel('diamond', 5);
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
            Openbw(idy, idx) = img(idy-row+1, idx-col+1);
        end
    end
end
figure, imshow(Openbw), title('Local Open');
%%
stats = regionprops(Openbw, 'BoundingBox', 'Area', 'Centroid', 'Image', 'PixelList');
centroids = cat(1, stats.Centroid);
figure, imshow(img_origin), title('FF');
hold on
for i = 1:size(stats)
    area = stats(i).Area;
    if area > lowerbound && area < upperbound
        rectangle('Position',[stats(i).BoundingBox],'LineWidth', 1.5,'LineStyle','-','EdgeColor','r'),
        plot(centroids(i,1), centroids(i,2), 'b*');
    end
end
hold off