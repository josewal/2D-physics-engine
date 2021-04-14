clc, clear all

r = [10, 25];
v = [0, 0];
a = [1, -0.2];

canvas = zeros(100);
 
for i = 1:200
v = v + a;
r = r + v;

if r(1) > size(canvas, 1)
    r(1) = size(canvas, 1);
    v(1) = -v(1);
elseif r(1) < 1
    r(1) = 1;
    v(1) = -v(1);
end

if r(2) > size(canvas, 2)
    r(2) = size(canvas, 2);
    v(2) = -v(2);
elseif r(2) < 1
    r(2) = 1; 
    v(2) = -v(2);
end

j = floor(r);

canvas(j(1), j(2)) = 1;
imshow(rot90(canvas), "InitialMagnification", "fit")
canvas = canvas*0;

pause(0.01)
end