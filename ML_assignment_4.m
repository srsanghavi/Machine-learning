close all;
clear all;
img=rgb2gray(imread('image/texture.png'));
[m n]=size(img);
mean1=zeros(m,n);
E=zeros(m,n);

for i=1:m
    for j=1:n
        cropped=imcrop(img,[j i 20 20]);
        mean1(i,j)=mean2(cropped(:));
        E(i,j)=entropy(cropped);
    end
end
datam = reshape(mean1,1,m*n);
datae = reshape(E,1,m*n);
data=[datam(:) datae(:)];

%4-means clustering
[idx,C,sumd] = kmeans(data,4);
%plotting the clusters 
figure;
plot(data(idx==1,1),data(idx==1,2),'r.','MarkerSize',12)
hold on
plot(data(idx==2,1),data(idx==2,2),'b.','MarkerSize',12)
hold on
plot(data(idx==3,1),data(idx==3,2),'g.','MarkerSize',12)
hold on
plot(data(idx==4,1),data(idx==4,2),'c.','MarkerSize',12)
hold on
plot(C(:,1),C(:,2),'kx',...
     'MarkerSize',15,'LineWidth',3)
legend('Cluster 1','Cluster 2','cluster 3','cluster 4','Centroids',...
       'Location','NW')
title 'Cluster Assignments and Centroids'
hold off


%image marking based on the cluster in which perticular pixel belongs to
for i=1:size(idx)
    switch(idx(i))
        case 1
            imx(uint16(i/m)+1,uint16(mod(i,n)+1))=255;
        case 2
            imx(uint16(i/m)+1,uint16(mod(i,n)+1))=0;
        case 3
            imx(uint16(i/m)+1,uint16(mod(i,n)+1))=200;
        case 4
            imx(uint16(i/m)+1,uint16(mod(i,n))+1)=120;
     end
end
imshow(uint8(imx))
