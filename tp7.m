clear all
close all
clc
pkg load image

img = imread ('desmatada.jpg');%Fazendo a leitura da imagem
%figure,imshow(img);title('original'); % Visualizando
%figure,imhist(img);title('original');  % Histograma

gray_img = rgb2gray(img);
%figure, imshow(gray_img), title ('Grayscale image');
%figure, imhist(gray_img), title ('Grayscale image');

threshold = graythresh(gray_img);
bw = im2bw(gray_img,threshold);
[B,L] = bwboundaries(bw);
figure,imshow(label2rgb(L, @jet, [.5 .5 .5]));
hold on
for k = 1:length(B)
  boundary = B{k};
  plot(boundary(:,2), boundary(:,1), 'black', 'LineWidth', 2)
end

%output = 130 - gray_img;
%figure, imshow(output), title ('output image');
%figure, imhist(output), title ('output image');