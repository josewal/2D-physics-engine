clc, clear
dt = 0.1;
b = Body([2,2])

for i = 1:50
    b.applyForce([0,-1])
    b.update(dt)
    
    b.plotBody()
    hold on
    b.plotBonds()
    hold on
    b.plotCOM();
    hold off
    
    pause(dt)
end