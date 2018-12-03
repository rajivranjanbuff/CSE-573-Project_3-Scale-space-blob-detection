clear all
img=imread('../data/butterfly.jpg');
imggray=rgb2gray(img);
imdo=im2double(imggray);
sigma=2;
scalelevel=12;
[h1,w]=size(imdo);
imgfinal=[h1,w,scalelevel];
temp=[];
k=1.5;

for i= 1:scalelevel
    sigma=sigma*k;
    h=fspecial('log',2*ceil((3*sigma)) + 1,sigma);
    h=h*sigma*sigma;    
    out=imfilter(imdo,h);
    imgfinal = cat(3, temp , out);
    temp = imgfinal;    
end
val=3;
thresh=.1;
maxval = zeros(h1, w, scalelevel);
rad=sigma*sqrt(2);
for i = 1:scalelevel
    maxval(:,:,i) = ordfilt2(imgfinal(:,:,i), val.^2, ones(val));
    maxval(:,:,i)= max(maxval(:,:,i),[],3);
    imgfinal = (imgfinal(:,:,i)==maxval(:,:,i))&(imgfinal(:,:,i)>thresh);       % Find maxima.
	[r,c] = find(imgfinal);  
    sigma=sigma*k;
    rad=sigma*sqrt(2);
show_all_circles(maxval, r, c, rad, 'r', 1);
end
