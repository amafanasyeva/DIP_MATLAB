% Вариант 2
clear;

% Шаг 1
I = uint8(zeros(800, 800));

% Шаг 2
noise = im2uint8(imnoise2('salt & pepper', 800, 800));
imshow(noise); pause;

% Шаг 3
histogram(noise);
saveas(gcf, 'hist.png');
pause;

% Шаг 4
object1 = noise;
a = 40;
center = (round(size(object1, 1)/2));
object1(center-2*a:center+2*a, center-a:center+a) = 255;
imshow(object1); 
pause;
imwrite(object1, 'object1.png')

% Шаг 5
nearset = imresize(object1, 2, 'nearest');
imshow(nearset); 
title('Масштабирование (метод ближайшего соседа)'); 
pause;
imwrite(nearset, 'nearset.png')
bilinear = imresize(object1, 0.5, 'bilinear');
imshow(bilinear); 
title('Масштабирование (билинейная интерполяция)'); 
pause;
imwrite(bilinear, 'bilinear.png')

% Шаг 6
offset1 = 100;
newnoise = im2uint8(imnoise2('salt & pepper', 800, 800));
newnoise(offset1-2*a:offset1+2*a, offset1-a/2:offset1+a/2) = 255;
newnoise(offset1-a/2:offset1+a/2, offset1-2*a:offset1+2*a) = 255;
offset2 = 800 - offset1;
side1 = offset2:offset2+2*a;
x_tr = [side1(1), side1(2*a), side1(2*a), side1(1)]; 
y_tr = [side1(1), side1(1), side1(2*a), side1(2*a)]; 
square1 = poly2mask(x_tr, y_tr, 800, 800);
square_perim1 = bwperim(square1, 4);
newnoise(square_perim1) = 255;
side2 = offset2+a/2:offset2+3*a/2;
x_tr = [side2(1), side2(a), side2(a), side2(1)]; 
y_tr = [side2(1), side2(1), side2(a), side2(a)]; 
square2 = poly2mask(x_tr, y_tr, 800, 800);
square_perim2 = bwperim(square2, 4);
newnoise(square_perim2) = 255;
imshow(newnoise); pause;

% Шаг 7
mirrorH = fliplr(newnoise);
imshow(mirrorH); 
pause;
imwrite(mirrorH, 'mirrorH.png');

% Шаг 8
mirrorV = flipud(mirrorH);
imshow(mirrorV); 
pause;
imwrite(mirrorV, 'mirrorV.png');

% Шаг 9
rotate45 = imrotate(mirrorV, -45);
imshow(rotate45); 
pause;
imwrite(rotate45, 'rotate45.png');

% Шаг 10
rotated_back = imrotate(rotate45, 45);
imshow(rotated_back); 
pause;
imwrite(rotated_back, 'rotated_back.png');

% Шаг 11
bg = imread("bg.jpg");
imshow(bg); 
pause;

% Шаг 12
cropped_bg = imcrop(bg, [0 0 800 800]);
imshow(cropped_bg);
pause;

% Шаг 13
dark_cropped_bg = cropped_bg/4;
imshow(dark_cropped_bg);
pause;

% Шаг 14
grey_cropped_bg = rgb2gray(dark_cropped_bg);
grey_cropped_bg(offset1-2*a:offset1+2*a, offset1-a/2:offset1+a/2) = 255;
grey_cropped_bg(offset1-a/2:offset1+a/2, offset1-2*a:offset1+2*a) = 255;
grey_cropped_bg(square_perim1) = 255;
grey_cropped_bg(square_perim2) = 255;
noisy_grey_cropped_bg = imnoise(grey_cropped_bg, 'salt & pepper');
imshow(noisy_grey_cropped_bg); 
pause;
imwrite(noisy_grey_cropped_bg, 'noisy_grey_cropped_bg.png')

% Шаг 15
negative = imcomplement(noisy_grey_cropped_bg);
imwrite(negative, 'negative.png');
imshow(negative); 
pause;

% Шаг 16
grey_cropped_bg2 = rgb2gray(dark_cropped_bg);
grey_cropped_bg2(center-2*a:center+2*a, center-a:center+a) = 255;
noisy_grey_cropped_bg2 = imnoise(grey_cropped_bg2, 'salt & pepper');
imshow(noisy_grey_cropped_bg2); 
pause;
imwrite(noisy_grey_cropped_bg2, 'noisy_grey_cropped_bg2.png')

% Шаг 17
imdiff = imabsdiff(noisy_grey_cropped_bg, noisy_grey_cropped_bg2);
imshow(imdiff);
imwrite(imdiff, 'imdiff.png')
