img = imread('stairs.jpg');
img = rgb2gray(img);
%img_e = edge(img, 'canny');
img_e = CannyFilter(img, 3, 1);
subplot(221);
imshow(img);
subplot(222);
imshow(img_e);
[H,T,R] = hough(img_e, 'Theta', -90:0.5:89.5);
subplot(223);
imshow(imadjust(mat2gray(H)), 'XData', T, 'YData', R, 'InitialMagnification', 'fit');
xlabel('\theta');ylabel('\rho');
axis on;
axis normal;
%colormap(gca, hot);
peaks = houghpeaks(H,5);
subplot(224);
imshow(img);
hold on;
lines = houghlines(img, T, R, peaks, 'FillGap',30, 'MinLength',30);

max_len = 0;
for k=1:length(lines)
xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',3,'Color','b');
   plot(xy(1,1),xy(1,2),'x','LineWidth',3,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',3,'Color','red');

   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

hold off;