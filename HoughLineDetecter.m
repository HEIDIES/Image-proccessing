%Hough transform
function[s, theta] = HoughLineDetecter(img)
    img_canny = CannyFilter(img, 5, 1);
    [loc,~] = Otsu(img_canny);
    
end