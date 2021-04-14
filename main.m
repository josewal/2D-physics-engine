clc, clear
dt = 0.05;
w = World()

for i = 1:100
    w.applyGravity()
    w.update(dt)
    
    w.bodies(1).plotBody()
    hold on
    w.bodies(1).plotBonds()
    hold on
    w.bodies(1).plotCOM();
    axis([0 3 -1 2])
    hold off
    
    pause(dt)
end