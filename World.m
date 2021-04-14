classdef World < handle
    properties
        body
    end
    
    methods
        function obj = World()
            obj.body = Body([2,2]);
        end
        
        function checkCollisions(obj)
            for i = 1:size(obj.body.particles,1)
                for j = 1:size(obj.body.particles,2)
                    if obj.body.particles(i,j).loc(2) <= 0
                        obj.body.particles(i,j).loc(2) = 0;
                        force = obj.calcNormalForce(i,j);
                        obj.body.particles(i,j).applyForce(force)
                    end
                end
            end
        end
        
        function force = calcNormalForce(obj, i, j)
            force = [0, 5];
        end
        
        function update(obj,dt)
            obj.body.applyForce([0,-1])
            obj.checkCollisions()
            obj.body.update(dt)
        end
    end
end