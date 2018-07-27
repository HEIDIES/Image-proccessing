clear all;
img = imread('waterPlaying.jpg');
[mag, dx, dy] = CannyFilter(img, 1);
figure;
imshow(img);

figure;
imshow(mag);

edge_image = CannyEdgeDetector(dx, dy, 15,45, 0);
figure;
imshow(edge_image);

figure;
imshow(edge(rgb2gray(img), 'canny'));