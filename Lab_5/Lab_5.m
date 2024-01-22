clear;

% Шаг 1
I = imread('image1.jpg');
I1 = im2bw(I);
imshow(I1);
square = strel('square', 20);
I2 = imopen(I1, square);
I3 = imclose(I1, square);
I4 = imclose(I2, square);
subplot(2,2,1); 
imshow(I1); 
title('Изображение с дефектом');
subplot(2,2,2); 
imshow(I2); 
title('Открытие');
subplot(2,2,3); 
imshow(I3);  
title('Закрытие');
subplot(2,2,4); 
imshow(I4); 
title('Отрытие + закрытие'); 
pause;
saveas(gcf, 'defect.png')

% Шаг 2
I = imread('image2.jpg');
I1 = im2bw(I);
I2 = ~I1;
subplot(2,2,1); 
imshow(I2); 
title('Original image');
BW2 = bwmorph(I1, 'erode', 7);
subplot(2,2,2); 
imshow(BW2); 
title('Eroded image');
BW2 = bwmorph(BW2, 'thicken', Inf);
subplot(2,2,3); 
imshow(BW2); 
title('Thickened objects');
I3 = ~(I1&BW2);
subplot(2,2,4); 
imshow(I3); 
title('Result'); 
pause;
saveas(gcf, 'separation.png')
B = strel('disk', 1);
A = imdilate(I3, B);
C = A & ~I3;
subplot(1,1,1); 
imshow(C); 
pause;
saveas(gcf, 'contour.png')

% Шаг 3
rgb = imread ('image3.jpg');
A = rgb2gray(rgb);
B = strel ('disk', 50);
C = imerode(A, B);
Cr = imreconstruct (C, A);
Crd = imdilate(Cr, B);
Crdr = imreconstruct (imcomplement (Crd) , imcomplement (Cr));
Crdr = imcomplement (Crdr);
imshow(Crdr); 
title('Отфильтрованное изображение'); 
pause; 
fgm = imregionalmax(Crdr);
A2 = A;
A2(fgm) = 255;
subplot(1, 2, 1); 
imshow(A2); 
title('Маркеры переднего плана');
B2 = strel(ones(20, 20));
fgm = imclose(fgm, B2);
fgm = imerode(fgm, B2);
fgm = bwareaopen(fgm, 20);
A3 = A;
A3(fgm) = 255;
subplot(1, 2, 2); 
imshow(A3); 
title('Отфильтрованные маркеры');
pause;
saveas(gcf, 'fgm.png')
bw = imbinarize(Crdr);
D = bwdist(bw);
L = watershed(D);
bgm = L == 0;
subplot(1, 1, 1); 
imshow(bgm); 
title('Маркеры фона'); 
pause;
saveas(gcf, 'bgm.png')
hy = fspecial('sobel');
hx = hy';
Ay = imfilter(im2double(A), hy, 'replicate');
Ax = imfilter(im2double(A), hx, 'replicate');
grad = sqrt(Ax.^2 + Ay.^2);
subplot(1, 2, 1); 
imshow(grad); 
title('Исходное');
grad = imimposemin(grad, bgm | fgm );
subplot(1, 2, 2); 
imshow(grad); 
title('Модифицированное'); 
pause;
saveas(gcf, 'grad.png')
L = watershed(grad);
A4 = A;
A4(imdilate (L == 0 , ...
    ones(3, 3)) | bgm | fgm ) = 255;
subplot(1, 2, 1); 
imshow(A4);
title(['Маркеры и границы, наложенные на исходное изображение']);
Lrgb = label2rgb(L , 'jet' , 'w' , 'shuffle');
subplot(1, 2, 2); 
imshow(Lrgb);
title('Представленное в цветах rgb');
saveas(gcf, 'Lrgb.png')