clc, clear
dt = 0.05;

w = World()

body_shape =    [1,     2,   1.5,   2;
    1,     1.5, 1.5,   1.5];
body1 = Body([2,2], body_shape);
w.addBody(body1)

body_shape =    [1,     2,   1.5,   2;
    1,     1.5, 1.5,   1.5] .* 2;
body2 = Body([2,2], body_shape);
w.addBody(body2)


for i = 1:100
    w.applyGravity()
    w.update(dt)
    w.plotWorld()
    pause(dt)
end