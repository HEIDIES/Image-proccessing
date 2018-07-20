function [ Corners, img_Harris ] = HarrisCornerDetect( img, win_size, k, sigma )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    stride = (win_size - 1) / 2;
    x = [-stride : 1 : stride];
    gx = exp(-x.^2 / (2 * sigma));
    gx = gx / sum(gx);
    gy = gx';
    
    if size(img, 3) > 1
        img = rgb2gray(img);
    end
    
    img = double(img) / 255.0;
    
    img_x = filter2(x.*gx, img);
    img_x = filter2(gy, img_x);
    
    img_y = filter2(x'.*gy, img);
    img_y = filter2(gx, img_y);
    
    [h, w] = size(img);
    Ixx = zeros(h, w);
    Ixy = zeros(h, w);
    Iyy = zeros(h, w);
    conv_sum = ones(win_size, win_size);
    
    Ixx(1+stride:h-stride, 1+stride:w-stride) = filter2(conv_sum, img_x.^2, 'valid');
    Ixy(1+stride:h-stride, 1+stride:w-stride) = filter2(conv_sum, img_x.*img_y, 'valid');
    Iyy(1+stride:h-stride, 1+stride:w-stride) = filter2(conv_sum, img_y.^2, 'valid');
    
    R = Ixx.*Iyy - Ixy.^2 - k * (Ixx + Iyy).^2;
    
    R_ = zeros(h, w);
    
    stride = stride + 1;
    for i = 1+stride:h-stride
        for j = 1+stride:w-stride
            R_(i,j) = max(max(R(i-stride:i+stride, j-stride:j+stride)));
            if R_(i,j) < 0
                R_(i,j) = 0;
            end
        end
    end
    
    R_(R_ ~= R) =0;
    scale = 0.005;
    threshold = max(max(R_)) * scale;
    
    [Y, X] = find(R_ > threshold);
    Corners = [X, Y];
    img_Harris = drawCross(img, Corners);
end

