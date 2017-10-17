%Inclass 13

%Part 1. In this directory, you will find an image of some cells expressing a 
% fluorescent protein in the nucleus. 
% A. Create a new image with intensity normalization so that all the cell
% nuclei appear approximately eqully bright. 

img=imread('Dish1Well8Hyb1Before_w0001_m0006.tif');
figure(1); imshow(img,[]);

img_nuc=im2double(img);
img_nucdilate=imdilate(img_nuc,strel('disk',60));
img_nucnorm=img_nuc./img_nucdilate;
imshow(img_nucnorm, []);

% B. Threshold this normalized image to produce a binary mask where the nuclei are marked true. 

img_mask=img_nucnorm>0.2;
figure(2); imshow(img_mask,[]);

% C. Run an edge detection algorithm and make a binary mask where the edges
% are marked true.

edgeimg=edge(img_nucnorm,'canny',[]);
figure(3); imshow(edgeimg,[]);

% D. Display a three color image where the orignal image is red, the
% nuclear mask is green, and the edge mask is blue. 

toshow=cat(3,img,im2double(img_mask),im2double(edgeimg));
figure(4); imshow(toshow);

%Part 2. Continue with your nuclear mask from part 1. 
%A. Use regionprops to find the centers of the objects

cell=regionprops(img_mask,'centroid');
centers=[cell.Centroid];

%B. display the mask and plot the centers of the objects on top of the
%objects

centroids = cat(1, cell.Centroid);
figure(5);
imshow(img_mask);
hold(imgca,'on');
plot(imgca,centroids(:,1), centroids(:,2), 'b*');
hold(imgca,'off');

%C. Make a new figure without the image and plot the centers of the objects
%so they appear in the same positions as when you plot on the image (Hint: remember
%Image coordinates). 

figure(6);
plot(centroids(:,1), centroids(:,2), 'b*') 
xlim([0 1024]);
ylim([0 1024]);