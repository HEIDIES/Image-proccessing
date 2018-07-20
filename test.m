img = imread('house.jpg');
img_canny = CannyFilter(img, 11, 1);
figure;
subplot(2,2,1);
imshow(img);
subplot(2,2,2);
imshow(img_canny);
subplot(2,2,3);
[~,img_threshold] = Otsu(img_canny);
imshow(img_threshold);
[~,img_Harris] = HarrisCornerDetect(img_canny, 5, 0.05, 1);
subplot(2,2,4);
imshow(img_Harris);