im=imread('../data/butterfly.jpg');


if size(im,3)>1
    im = mean(im,3)/255;
end
imshow(im);
sigma = 1.6;
k = sqrt(2);
sigma_final = power(k,16);
n = ceil((log(sigma_final) - log(sigma))/log(k));
[h, w] = size(im); 
scaleSpace = zeros(h, w, n);

% imshow(img)
% warning off
% im = rgb2gray(img);
% hx=[-1,1];
% hy=[-1;1];
% gx=filter2(hx,im);
% gy=filter2(hy,im);
% 
% figure
% imshow(abs(gx),[]);


