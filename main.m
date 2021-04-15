clc, clear
dt = 0.015;

w = World();

body_shape =    [1,     5,    1.5,    5,    2,    5;
                1,      4.5,  1.5,    4.5,  2,    4.5;
                1,      4,    1.5,    4     2,    4;
                1,      3.5,  1.5,    3.5,  2,    3.5];
body1 = Body([4,3], body_shape);
w.addBody(body1)


for i = 1:200
    if i < 20
        body1.particles(4,3).applyForce([0,200])
        body1.particles(4,2).applyForce([200,0])
        body1.particles(1,2).applyForce([-200,0])
    end
    w.applyGravity()
    w.update(dt)
    w.plotWorld()
    pause(dt/10)
end