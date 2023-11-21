clear;

% Шаг 2
cat=imread('C:\Users\User\Desktop\iтмо\DIP\DIP_MATLAB\cat.jpg');

% Шаг 3
imshow(cat);
pause;

% Шаг 4,5
imwrite(cat, 'cat.jpg');
imwrite(cat, 'cat.png');

% Шаг 6
info_jpg=imfinfo('cat.jpg');
info_png=imfinfo('cat.png');

% Шаг 7
Ks_jpg=((info_jpg.Width*info_jpg.Height*info_jpg.BitDepth)/8)/(info_jpg.FileSize);
Ks_png=((info_png.Width*info_png.Height*info_png.BitDepth)/8)/(info_png.FileSize);

% Шаг 8
cat_grey=rgb2gray(cat);
imshow(cat_grey);
pause;
imwrite(cat_grey, 'cat_grey.jpg');

% % Шаг 9
% logical25=imbinarize(cat_grey, 0.25);
% imshow(logical25);
% pause;
% imwrite(logical25, 'Logical/logical25.jpg');
% 
% logical50=imbinarize(cat_grey, 0.50);
% imshow(logical50);
% pause;
% imwrite(logical50, 'Logical/logical50.jpg');
% 
% logical75=imbinarize(cat_grey, 0.75);
% imshow(logical75);
% pause;
% imwrite(logical75, 'Logical/logical75.jpg');
% 
% % Шаг 10
% for i=1:8
%     cat_i = logical(bitget(cat_grey, i));
%     imshow(cat_i); pause;
%     imwrite(cat_i, ['BitPlane/cat_' int2str(i) '.jpg'] )
% end

% % Шаг 11
% for i=[5, 10, 20, 50]
%     cat_i=mat2gray(blkproc(cat_grey, [i i], 'mean2(x)*ones(size(x))'));
%     imshow(cat_i); pause;
%     imwrite(cat_i, ['Discret/cat_' int2str(i) '.jpg']);
% end
% 
% % Шаг 12
% for i=[4, 16, 32, 64, 128]
%     levels = linspace(0, 255, i+1);
%     cat_i = mat2gray(imquantize(cat_grey,levels));
%     imshow(cat_i); pause;
%     imwrite(cat_i, ['Quantiz/cat_' int2str(i) '.jpg']);
% end

% Шаг 13
TargetSize = [100, 100];
r = centerCropWindow2d(size(cat_grey),TargetSize);
cat_crop = imcrop(cat_grey,r);
imshow(cat_crop); pause;
imwrite(cat_crop, 'Crop/cat_crop.jpg');

% Шаг 14
N1=[cat_grey(20,17), cat_grey(21,16), cat_grey(22,17), cat_grey(21,18)];
N2=[cat_grey(14,10), cat_grey(16,10), cat_grey(14,12), cat_grey(16,12)];
N3=[cat_grey(18,87), cat_grey(18,88), cat_grey(18,89), cat_grey(19,87), cat_grey(20,87), cat_grey(20,88), cat_grey(20,89)];

% Шаг 15
brightness_mean=mean(mean(cat_grey));

% Шаг 16
cat_marks=cat_grey;
TargetSize = 20;
cat_crop_1 = imcrop(cat_grey, [0 0 TargetSize TargetSize]);
cat_crop_2 = imcrop(cat_grey, [0 info_jpg.Height+1-TargetSize TargetSize TargetSize]);
cat_crop_3 = imcrop(cat_grey, [info_jpg.Width+1-TargetSize 0 TargetSize TargetSize]);
cat_crop_4 = imcrop(cat_grey, [info_jpg.Width+1-TargetSize info_jpg.Height+1-TargetSize TargetSize TargetSize]);
cat_crop_5 = imcrop(cat_grey, [(info_jpg.Width-TargetSize)/2 (info_jpg.Height-TargetSize)/2 TargetSize-1 TargetSize-1]);

imcell={cat_crop_1, cat_crop_2, cat_crop_3, cat_crop_4, cat_crop_5};
for i=1:5
    brightness_mean=mean(mean(imcell{1, i}));
    if brightness_mean<128
        imcell{1, i}(:,:)=255;
    else 
        imcell{1, i}(:,:)=0;
    end
  
end
cat_marks(1:TargetSize, 1:TargetSize)=imcell{1, 1}(:,:);
cat_marks(info_jpg.Width+1-TargetSize:info_jpg.Width, 1:TargetSize)=imcell{1, 2}(:,:);
cat_marks(1:TargetSize, info_jpg.Height+1-TargetSize:info_jpg.Height)=imcell{1, 3}(:,:);
cat_marks(info_jpg.Width+1-TargetSize:info_jpg.Width, info_jpg.Height+1-TargetSize:info_jpg.Height)=imcell{1, 4}(:,:);
cat_marks(((info_jpg.Width+1-TargetSize)/2):((info_jpg.Width+TargetSize)/2), ((info_jpg.Height+1-TargetSize)/2):((info_jpg.Height+TargetSize)/2))=imcell{1, 5}(:,:);
imshow(cat_marks); pause;


