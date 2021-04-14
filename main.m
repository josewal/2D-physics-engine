clc, clear
dt = 0.1;
w = World()

for i = 1:50
    w.update(dt)
    
    w.body.plotBody()
    hold on
    w.body.plotBonds()
    hold on
    w.body.plotCOM();
    axis([0 3 -2 2])
    hold off
    
    pause(dt)
end