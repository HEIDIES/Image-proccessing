function [ img ] = drawCross( img, point_set )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
    X = point_set(:,1);
    Y = point_set(:,2);
    num_points = size(point_set, 1);
    for i = 1:num_points
        img(Y(i)-3:Y(i)+3, X(i)) = 255;
        img(Y(i), X(i)-3:X(i)+3) = 255;
    end
end

