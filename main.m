clc, clear
canvas = zeros(200);

p = Particle();

for i = 1:100
    p.applyForce([1; 1])
    p.update()
    p.loc
    plot(p.loc(1), p.loc(2), "o")
    
    pause(0.1)
end