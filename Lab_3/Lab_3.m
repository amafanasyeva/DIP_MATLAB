% Вариант 6
clear;

%% 1 Портрет и гистограмма
I = imread('photo_2024-01-22_04-43-21.jpg');
I = rgb2gray(imcrop(I, [160 240 799 799]));
imwrite(I, 'portrait.png');
histogram(I);
saveas(gcf, 'hist.png');
pause;

%% 2 Логарифмическое преобразование
g = log(1 + im2double(I));
imshow(g); 
pause;
imwrite(g, 'Log/g.png');
histogram(g);
saveas(gcf, 'Log/hist.png');
pause;

%% 3 Степенное проебразование
for gamma = [0.1 0.45 5]
    g = im2double(I).^gamma;
    imshow(g);
    pause;
    imwrite(g, ['Degree/' sprintf('%.2f', gamma) '.png']);
    histogram(g); 
    pause;
    saveas(gcf, ['Degree/hist' sprintf('%.2f', gamma) '.png']);
end

%% 4 Кусочно-линейное преобразование
points = [0, 255; 120, 120; 120, 250; 180, 250; 180, 75; 255, 0];
x = points(:, 1);
y = points(:, 2);
g = zeros(800, 800);
for i = 1:800
    for j = 1:800
        if (I(i, j) >= 0 && I(i, j) <= 120) || (I(i, j) >= 180 && I(i, j) <= 255)
            g(i, j) = -1 * double(I(i, j)) + 255;
        else 
            g(i, j) = 250;
        end
    end
end
g1 = uint8(g);
imshow(g1);
pause;
imwrite(g1, 'Line_Contrast/g.png');
histogram(g1); 
pause;
saveas(gcf, 'Line_Contrast/hist.png');

%% 5 Эквализация
g = histeq(I);
imshow(g); 
pause;
imwrite(g, 'Equaliz/g.png');
histogram(g); pause;
saveas(gcf, 'Equaliz/hist.png');

%% 6 Усредняющий фильтр
for size = [3 15 35]
    g = imfilter(I, fspecial('average', size));
    imshow(g); 
    pause;
    imwrite(g, ['Filter/average' num2str(size) '.png']);
end

%% 7 Фильтр повышения резкости
g2 = imfilter(im2double(I), fspecial('laplacian', 0));
g = im2double(I) - g2;
imshow(g);
pause;
imwrite(g, 'Filter/sharp.png');

%% 8 Медианный фильтр
for size = [3 9 15]
    g = medfilt2(I, [size size]);
    imshow(g); 
    pause;
    imwrite(g, ['Median/' num2str(size) '.png']);
end

%% 9 Выделение границ
g1 = edge(I, 'roberts');
imshow(g1);
pause;
imwrite(g1, 'Edge/roberts.png');
g2 = edge(I, 'prewitt');
imshow(g2); 
pause;
imwrite(g2, 'Edge/prewitt.png');
g3 = edge(I, 'sobel');
imshow(g3); 
pause;
imwrite(g3, 'Edge/sobel.png');

%% 10 Фильтрация шума
noise = imnoise2('salt & pepper', 800, 800, 0.1/255, 0.8/255);
salt = find(noise == 1);
noisy = I;
noisy(salt) = 255;
pepper = find(noise == 0);
noisy(pepper) = 0;
imshow(noisy);
pause;
imwrite(noisy, 'Filter/noisy.png');
g1 = imgaussfilt(noisy);
g2 = medfilt2(noisy);
imshow(g2);
pause;
imwrite(g2, 'Filter/filtered.png');
g3 = imfilter(noisy, fspecial('average'));
N = 800*800;
D = sum((I-((1/N)*sum(I, 'all'))).^2, 'all')/N;
D1 = sum((g1-((1/N)*sum(g1, 'all'))).^2, 'all')/N;
D2 = sum((g2-((1/N)*sum(g2, 'all'))).^2, 'all')/N;
D3 = sum((g3-((1/N)*sum(g3, 'all'))).^2, 'all')/N;
