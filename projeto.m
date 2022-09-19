clear all
close all
clc
pkg load image

img = imread ('lego.jpg');%Fazendo a leitura da imagem

%Realçar as cores
R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);
Rr = imadjust(R);
Gr = imadjust(G);
Br = imadjust(B);
imgr = cat(3,Rr,Gr,Br);

figure
subplot (1, 2, 1);
imshow(img);title("Imagem original");
subplot (1, 2, 2);
imshow(imgr);title("Imagem melhorada");

%Solução para o problema da borda
[im_ro, im_co, im_ch] = size(imgr);
f_double = double(imgr);
%Tamanho e cor da borda
bw = 2; %Tamanho da borda
color = ones(1, 1, im_ch);
color(1, 1, :) = [0, 0, 0]; %Escolhendo a cor da borda para o amarelo [0, 255, 255]
% Gera uma imagem do mesmo tamanho da entrada com cor sólida e cole a parte interna da entrada
img_border = ones(im_ro, im_co, im_ch) .* color;
img_border(bw+1:end-bw, bw+1:end-bw, :) = f_double(bw+1:end-bw, bw+1:end-bw, :);
img_border = uint8(img_border);


%Faz a detecção e a contagem de objetos amarelo
amarelo = img_border(:,:,2)<200;
[B,L] = bwboundaries(amarelo);
stats = regionprops(L, 'Area');
maxArea = max([stats.Area]);
qtdAreaMax = sum([stats.Area] == maxArea);
qtdAreaMin = sum([stats.Area] > 700);
qtd_amarelo = qtdAreaMin - qtdAreaMax;
figure
imshow(img_border), title("Original com borda");
figure,imshow(amarelo), title("Objetos amarelos");
figure,imshow(imgr), title(sprintf('\\fontsize{16}{Existem %d objetos amarelos nessa imagem}', qtd_amarelo));
 %Coloca o valor da area para daca peça na imagem. Obs: Tamanho em pixels
hold on
for k = 1:length(B)
  area = stats(k).Area;
  if area > 700 && area < maxArea
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'k', 'linewidth', 2);
    text(boundary(1,2), boundary(1,1), sprintf('%.0f',area),...
    'Color', 'white',...
    'FontSize', 9,...
    'BackgroundColor', 'k');
  endif
endfor
hold off

%Faz a detecção e a contagem de objetos azuis
azuis = img_border(:,:,3) < 140;
[B,L] = bwboundaries(azuis);
stats = regionprops(L, 'Area');
maxArea = max([stats.Area]);
qtdAreaMax = sum([stats.Area] == maxArea);
qtdAreaMin = sum([stats.Area] > 1000);
qtd_azuis = qtdAreaMin - qtdAreaMax;
figure,imshow(azuis), title("Objetos azuis");
figure,imshow(imgr), title(sprintf('\\fontsize{16}{Existem %d objetos azuis nessa imagem}', qtd_azuis));

hold on
for k = 1:length(B)
  area = stats(k).Area;
  if area > 700 && area < maxArea
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'k', 'linewidth', 2);
    text(boundary(1,2), boundary(1,1), sprintf('%.0f',area),...
    'Color', 'white',...
    'FontSize', 9,...
    'BackgroundColor', 'k');
  endif
endfor
hold off

