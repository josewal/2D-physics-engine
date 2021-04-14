classdef Body < handle
    properties
        com
        particles
    end
    
    methods
        function obj = Body(size)
            for i = 1:size(1)
                for j = 1:size(2)
                    display([i j])
                    particles(i,j) = Particle();
                    particles(i,j).set([i;j], [0;0], 1)
                end
            end
            obj.particles = particles;
        end
        
        function update(obj)
            for i = 1:size(obj.particles, 1)
                for j = 1:size(obj.particles, 2)
                    obj.particles(i,j).update()
                end
            end
        end
        
        function resolveInnerForces()
            
        end
        
        function dist = calcDist(A, B)
            dist = (A.^2 + B.^2);
        end
    end
end