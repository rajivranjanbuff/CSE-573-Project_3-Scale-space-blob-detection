%all the input images have been placed in the data folder
%THEY ARE TAKEN ONE BY ONE THE time elapsed for them is shown 
%these images have not been provided as they we had to submit only the
%output of these images in the output folder
%it contains a total of 8 images as input, 4 were provided and 4 were
%chosen by me
%rajivranjan
%ub50249099
clear all

srcFiles = dir('../data/*.jpg');  
for j = 1 : length(srcFiles)
    filename = strcat('../data/',srcFiles(j).name);
    img = imread(filename);

% img =imread('../data/im4.jpg');
tic
imggray=rgb2gray(img);
imdo=im2double(imggray);
sigma=2;  
% sigma=1;
% sigma=3;
scalelevel=12;
% scalelevel=15;
% scalelevel=10;
[h1,w]=size(imdo);
imgfinal=[h1,w,scalelevel];
temp=[];
k=1.27;
% k=1.5;
% k=1.1;

for i= 1:scalelevel
    h=fspecial('log',2*ceil((3*sigma)) + 1,sigma);
    h=h*sigma*sigma;    
   
   
    out=imfilter(imdo,h,'replicate');
    out = out.*out;
    imgfinal = cat(3, temp , out);
    temp = imgfinal;  
    sigma=sigma*k;
end

val=3;
% val=5;
% thresh=.1;
thresh=.007;
maxval = zeros(h1, w, scalelevel);
rad=sigma*sqrt(2);
temp1=[];temp2=[];temp3=[];
temp4=[];
for i = 1:scalelevel
    img1 = imgfinal(:,:,i);
    maximg = ordfilt2(img1, val.^2, ones(val));
    maximgfinal=cat(3,temp4,maximg);
    temp4=maximgfinal;
end
maximg2dfinal=maximgfinal;
maximum=max(maximgfinal,[],3);
maximgfinal = maximgfinal.*(maximgfinal == maximum);
sigma=2;
for i= 1:scalelevel
    img1 = imgfinal(:,:,i);
    img2=maximgfinal(:,:,i);
    imgfin = img1.*((img1==img2)&(img1>thresh)); 
    
    
    % Find maxima.
	[r,c] = find(imgfin);  
   
    rad=sigma*sqrt(2);
    sigma=sigma*k;
    xcord=cat(1,temp1,r);   
    temp1 = xcord;
    
    ycord=cat(1,temp2,c);
    temp2 = ycord;
    
    radius = ones(size(r,1),1)*rad;
    finalrad = cat(1,temp3,radius);
    temp3= finalrad;
      
end

show_all_circles(imggray, ycord, xcord, finalrad, 'r', 1);

toc
end               


