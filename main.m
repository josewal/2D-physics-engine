clc, clear
dt = 0.0075;

w = World();

a = [1,0,0,0;1,1,0,0;0,1,1,1;0,0,1,0];
b = ones(6);
s = ShapeConstructor(b)

w.addBody(s, [2.5,5])


for i = 1:200
%     if i < 20
%         body1.particles(4,3).applyForce([0,200])
%         body1.particles(4,2).applyForce([200,0])
%         body1.particles(1,2).applyForce([-200,0])
%     end
%     
%     if (i > 20) && (i < 30)
%         body1.particles(4,2).applyForce([0,100])
%         body1.particles(1,2).applyForce([0,-100])
%     end
    w.applyGravity()
    w.update(dt)
    w.plotWorld()
    pause(dt/10)
end