function [ magnitude, dx, dy] = CannyFilter( img, sigma )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
    filter_size = 1 + 2 * ceil(3 * sigma);
    stride = (filter_size - 1) / 2;
    x = -stride : 1 : stride;
    gx = exp(-x.^2 / (2 * sigma * sigma));
    %gx = gx / sum(gx);
    gy = gx';
    if size(img, 3) == 3
        img = rgb2gray(img);
        %img_r = double(img(:,:,1)) / 255.0;
        %img_g = double(img(:,:,2)) / 255.0;
        %img_b = double(img(:,:,3)) / 255.0;
        
        %img_x_r = filter2(x.*gx, img_r);
        %img_x_g = filter2(x.*gx, img_g);
        %img_x_b = filter2(x.*gx, img_b);
        
        %img_x_r = filter2(gy, img_x_r);
        %img_x_g = filter2(gy, img_x_g);
        %img_x_b = filter2(gy, img_x_b);
        
        %img_y_r = filter2(x'.*gy, img_r);
        %img_y_g = filter2(x'.*gy, img_g);
        %img_y_b = filter2(x'.*gy, img_b);
        
        %img_y_r = filter2(gx, img_y_r);
        %img_y_g = filter2(gx, img_y_g);
        %img_y_b = filter2(gx, img_y_b);
        
        %img_canny_r = (img_x_r.^2 + img_y_r.^2).^0.5;
        %img_canny_g = (img_x_g.^2 + img_y_g.^2).^0.5;
        %img_canny_b = (img_x_b.^2 + img_y_b.^2).^0.5;
        
        %magnitude(:,:,1) = img_canny_r(:,:,1);
        %magnitude(:,:,2) = img_canny_g(:,:,1);
        %magnitude(:,:,3) = img_canny_b(:,:,1);
        
        %magnitude = uint8(magnitude * 255.0);
    end
    img = double(img);
    img_x = filter2(x.*gx, img);
    img_x = filter2(gy, img_x);

    img_y = filter2(x'.*gy, img);
    img_y = filter2(gx, img_y);
            
    dx = int16(img_x);
    dy = int16(img_y);

    magnitude = (img_x.^2 + img_y.^2).^0.5;
    magnitude = uint8(magnitude);
        
end

