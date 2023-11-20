clear;

cat_jpg=imread('cat.jpg');
cat_png=imread('cat.png');
info_jpg=imfinfo('cat.jpg');
info_png=imfinfo('cat.png');

% Шаг 7
Ks_jpg=((info_jpg.Width*info_jpg.Height*info_jpg.BitDepth)/8)/(info_jpg.FileSize);
Ks_png=((info_png.Width*info_png.Height*info_png.BitDepth)/8)/(info_png.FileSize);

% Шаг 8
cat_grey_jpg=rgb2gray(cat_jpg);
imshow(cat_grey_jpg);
pause;
imwrite(cat_grey_jpg, 'cat_grey.jpg');

% Шаг 9
logical25=imbinarize(cat_grey_jpg, 0.25);
imshow(logical25);
pause;
imwrite(logical25, 'Logical/logical25.jpg');

logical50=imbinarize(cat_grey_jpg, 0.50);
imshow(logical50);
pause;
imwrite(logical50, 'Logical/logical50.jpg');

logical75=imbinarize(cat_grey_jpg, 0.75);
imshow(logical75);
pause;
imwrite(logical75, 'Logical/logical75.jpg');

% Шаг 10
