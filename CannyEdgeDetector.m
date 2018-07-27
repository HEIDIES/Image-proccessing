function [ edge_image ] = CannyEdgeDetector( dx, dy, low_threshold, high_threshold, L2gradient )
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细说明
    tg22 = round(0.4142135623730950488016887242097 * (2 ^ 14) + 0.5);
    tg67 = round(2.4142135623730950488016887242097 * (2 ^ 14) + 0.5);
    height = size(dx, 1);
    width = size(dx, 2);
    gradient_direction = zeros(height, width);
    edge_image = ones(height, width);
    
    if L2gradient == 1
        low_threshold = low_threshold ^ 2;
        high_threshold = high_threshold ^ 2;
        mag = (dx.^2 + dy.^2);
    else
        mag = abs(dx) + abs(dy);
    end
    count = 0;
    dx_tg22 = tg22 * abs(dx);
    dx_tg67 = tg67 * abs(dx);
    dy_ = abs(dy) * (2 ^ 14);
    tg22yx = dy_ - dx_tg22;
    tg67yx = dy_ - dx_tg67;
    dxy = dx .* dy;
    gradient_direction(tg22yx < 0) = 0; 
    gradient_direction(tg67yx > 0) = 1;
    gradient_direction(dxy < 0) = 2;
    gradient_direction(dxy > 0) = 3;
    prev_flag = 0;
    for i = 2 : height - 1
        for j = 2 : width - 1
            if mag(i, j) > low_threshold
                if gradient_direction(i, j) == 0
                    if mag(i, j) >= mag(i, j - 1) && mag(i, j) >= mag(i, j + 1)
                        if prev_flag == 0 && edge_image(i - 1, j) ~= 2 && mag(i, j) > high_threshold
                            count = count + 1;
                            edge_image(i, j) = 2;
                            prev_flag = 1;
                        else
                            edge_image(i, j) = 0;
                        end
                    else
                        prev_flag = 0;
                    end
                elseif gradient_direction(i, j) == 1
                    if mag(i, j) >= mag(i - 1, j) && mag(i, j) >= mag(i + 1, j)
                        if prev_flag == 0 && edge_image(i - 1, j) ~= 2 && mag(i, j) > high_threshold
                            count = count + 1;
                            edge_image(i, j) = 2;
                            prev_flag = 1;
                        else
                            edge_image(i, j) = 0;
                        end
                    else
                        prev_flag = 0;
                    end
                
                elseif gradient_direction(i, j) == 3
                    if mag(i, j) >= mag(i - 1, j - 1) && mag(i, j) >= mag(i + 1, j + 1)
                        if prev_flag == 0 && edge_image(i - 1, j) ~= 2 && mag(i, j) > high_threshold
                            count = count + 1;
                            edge_image(i, j) = 2;
                            prev_flag = 1;
                        else
                            edge_image(i, j) = 0;
                        end
                    else
                        prev_flag = 0;
                    end
                
                elseif gradient_direction(i, j) == 2
                    if mag(i, j) >= mag(i - 1, j + 1) && mag(i, j) >= mag(i + 1, j - 1)
                        if prev_flag == 0 && edge_image(i - 1, j) ~= 2 && mag(i, j) > high_threshold
                            count = count + 1;
                            edge_image(i, j) = 2;
                            prev_flag = 1;
                        else
                            edge_image(i, j) = 0;
                        end
                    else
                        prev_flag = 0;
                    end
                end
            end
        end
    end
    while count > 0
        for i = 2 : height - 1
            for j = 2 : width - 1
                if edge_image(i, j) == 2
                    edge_image(i, j) = 3;
                    count = count - 1;
                    if edge_image(i, j - 1) == 0
                        edge_image(i, j - 1) = 2;
                        count = count + 1;
                    end
                    if edge_image(i, j + 1) == 0
                        edge_image(i, j + 1) = 2;
                        count = count + 1;
                    end
                    if edge_image(i - 1, j) == 0
                        edge_image(i - 1, j) = 2;
                        count = count + 1;
                    end
                    if edge_image(i + 1, j) == 0
                        edge_image(i + 1, j) = 2;
                        count = count + 1;
                    end
                    if edge_image(i + 1, j + 1) == 0
                        edge_image(i + 1, j + 1) = 2;
                        count = count + 1;
                    end
                    if edge_image(i + 1, j - 1) == 0
                        edge_image(i + 1, j - 1) = 2;
                        count = count + 1;
                    end
                    if edge_image(i - 1, j + 1) == 0
                        edge_image(i - 1, j + 1) = 2;
                        count = count + 1;
                    end
                    if edge_image(i - 1, j - 1) == 0
                        edge_image(i - 1, j - 1) = 2;
                        count = count + 1;
                    end
                end
            end
        end
    end
    edge_image(edge_image == 1) = 0;
    edge_image(edge_image == 2) = 255;
    edge_image(edge_image == 3) = 255;
end

