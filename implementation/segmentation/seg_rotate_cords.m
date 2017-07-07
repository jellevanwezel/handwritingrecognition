function [ xR, yR ] = seg_rotate_cords( x, y , angle)
    xR = y * sind(angle) + x * cosd(angle);
    yR = y * cosd(angle) - x * sind(angle);
end

