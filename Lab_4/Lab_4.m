clear;

% Шаг 1
I = imread('portrait.png');
F = fft2(I);
Fc = fftshift(F);
S = log(1+abs(Fc));
imshow(S, []); 
title('Фурье спектр'); 
pause;
saveas(gcf, 'fourier.png')

% Шаг 2
n = 2;
[x, y] = meshgrid(1:800, 1:800);
D = sqrt((x - 400).^2 + (y - 400).^2);
for D0 = [5 10 50 250]
    H = double(D <= D0);
    filteredFc = Fc.*H;
    filteredF = ifftshift(filteredFc);
    filteredI = uint8(abs(real(ifft2(filteredF))));
    imshow(filteredI, []); 
    title(['Идеальный ФНЧ (D0 = ', num2str(D0), ')']); 
    pause;
    imwrite(filteredI, ['Low/Ideal/' num2str(D0) '.png'])
    H = 1 ./ (1 + (D ./ D0).^(2*n));
    filteredFc = Fc.*H;
    filteredF = ifftshift(filteredFc);
    filteredI = uint8(abs(real(ifft2(filteredF))));
    imshow(filteredI, []); 
    title(['Баттерворт ФНЧ (D0 = ', num2str(D0), ')']); 
    pause;
    imwrite(filteredI, ['Low/Butter/' num2str(D0) '.png'])
    H = exp(-(D.^2) ./ (2 * D0^2));
    filteredFc = Fc.*H;
    filteredF = ifftshift(filteredFc);
    filteredI = uint8(abs(real(ifft2(filteredF))));
    imshow(filteredI, []); 
    title(['Гаус ФНЧ (D0 = ', num2str(D0), ')']); 
    pause;
    imwrite(filteredI, ['Low/Gaus/' num2str(D0) '.png'])
end

% Шаг 2
for D0 = [5 10 50 250]
    H = double(D >= D0);
    filteredFc = Fc.*H;
    filteredF = ifftshift(filteredFc);
    filteredI = uint8(abs(real(ifft2(filteredF))));
    imshow(filteredI, []); 
    title(['Идеальный ФВЧ (D0 = ', num2str(D0), ')']); 
    pause;
    imwrite(filteredI, ['High/Ideal/' num2str(D0) '.png'])
    H = 1 ./ (1 + (D0 ./ D).^(2*n));
    filteredFc = Fc.*H;
    filteredF = ifftshift(filteredFc);
    filteredI = uint8(abs(real(ifft2(filteredF))));
    imshow(filteredI, []); 
    title(['Баттерворт ФВЧ (D0 = ', num2str(D0), ')']); 
    pause;
    imwrite(filteredI, ['High/Butter/' num2str(D0) '.png'])
    H = 1 - exp(-(D.^2) ./ (2 * D0^2));
    filteredFc = Fc.*H;
    filteredF = ifftshift(filteredFc);
    filteredI = uint8(abs(real(ifft2(filteredF))));
    imshow(filteredI, []); 
    title(['Гаус ФВЧ (D0 = ', num2str(D0), ')']); 
    pause;
    imwrite(filteredI, ['High/Gaus/' num2str(D0) '.png'])
end