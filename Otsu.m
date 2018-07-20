function [ loc, img_threshold ] = Otsu( img )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    hist = zeros(256, 1);
    if(size(img, 3) == 3)
        img = double(rgb2gray(img));
    end
    
    for i = 0 : 255
        hist(i + 1) = sum(sum(img == i));
    end
    
    [h, w] = size(img);
    
    sig = zeros(256, 1);
    
    hist = hist / (h * w);
    for i = 0:255
        if i == 0
            sig_b = 0;
            omi_b = 0;
        else
            sig_b = var(hist(1:i));
            omi_b = sum(hist(1:i)); 
        end
        sig_f = var(hist(i+1:256));
        omi_f = sum(hist(i+1:256));
        sig(i + 1) = sig_b * omi_b + sig_f * omi_f;
    end
    img_threshold = img;
    loc = find(sig == min(sig)) - 1;
    img_threshold(img > loc) = 255;
    img_threshold(img < loc) = 0;
end

