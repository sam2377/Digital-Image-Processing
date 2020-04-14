g = imread('./pic/breast.tif');
imshow(g);

g1 = imadjust(g,[0 1],[1 0],1);
figure;
subplot(1,4,1), imshow(g1);

g2 = imcomplement(g);
subplot(1,4,2), imshow(g2);

g3 = imadjust(g,[ ],[ ],0.5); % gamma change brightness
subplot(1,4,3), imshow(g3);

g4 = imadjust(g,stretchlim(g),[]);
subplot(1,4,4), imshow(g4);