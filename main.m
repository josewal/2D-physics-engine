clc, clear
dt = 0.05;

w = World()

body_shape =    [1,     2.5,    1.5,    2.5,    2,    2.5;
                1,      2,      1.5,    2,      2,    2;
                1,      1.5,    1.5,    1.5     2,    1.5;
                1,      1,      1.5,    1,      2,    1];
body1 = Body([4,3], body_shape);
w.addBody(body1)


for i = 1:100
    w.applyGravity()
    w.update(dt)
    w.plotWorld()
    pause(dt)
end