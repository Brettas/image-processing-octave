clear all
close all
clc
pkg load image

img = imread ('lego2.jpg');%Fazendo a leitura da imagem
imshow(img),title("Original");

%Solução para o problema da borda
[im_ro, im_co, im_ch] = size(img);
f_double = double(img);
%Tamanho e cor da borda
bw = 4; %Tamanho da borda
color = ones(1, 1, im_ch);
color(1, 1, :) = [255, 0, 0]; %Escolhendo a cor da borda
% Gera uma imagem do mesmo tamanho da entrada com cor sólida e cole a parte interna da entrada
img_border = ones(im_ro, im_co, im_ch) .* color;
img_border(bw+1:end-bw, bw+1:end-bw, :) = f_double(bw+1:end-bw, bw+1:end-bw, :);
img_border = uint8(img_border);
imshow(img_border),title("Original com borda");;

%Faz a detecção e a contagem de objetos azuis
azuis = img_border(:,:,3) < 98;
[B,L] = bwboundaries(azuis);
stats = regionprops(L, 'Area');
maxArea = max([stats.Area]);
minArea = min([stats.Area]>1000);
qtdAreaMax = sum([stats.Area] == maxArea);
qtdAreaMin = sum([stats.Area] > 1000);
qtd_azuis = qtdAreaMin - qtdAreaMax;

imshow(azuis);
title(sprintf('\\fontsize{16}{Existem %d objetos azuis nessa imagem}', qtd_azuis));


%Coloca o valor da area para daca peça na imagem. Obs: Tamanho em pixels
hold on
for k = 1:length(B)
  area = stats(k).Area;
  if area > 1000 && area < maxArea
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'k', 'LineWidth', 1);
    text(boundary(1,2), boundary(1,1), sprintf('%.0f',area),...
    'Color', 'black',...
    'FontSize', 9,...
    'BackgroundColor', 'y');
  endif
endfor
hold off
