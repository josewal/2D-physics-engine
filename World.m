classdef World < handle
    properties
        bodies
        g = [0, -9.81];
    end
    
    methods
        function obj = World()
        end
        
        function checkCollisions(obj)
            for n = 1:length(obj.bodies)
                for i = 1:size(obj.bodies(n).particles,1)
                    for j = 1:size(obj.bodies(n).particles,2)
                        if obj.bodies(n).particles(i,j).loc(2) <= 0
                            obj.bodies(n).particles(i,j).loc(2) = 0;
                            obj.bodies(n).particles(i,j).vel(2) = -obj.bodies(n).particles(i,j).vel(2);
                            force = obj.calcNormalForce(i,j);
                            obj.bodies(n).particles(i,j).applyForce(force)
                        end
                    end
                end
            end
        end
        
        function addBody(obj, shape_, r)
            body = Body(shape_);
            body.moveBody(r)
            obj.bodies = [obj.bodies, body];
        end
        
        function force = calcNormalForce(obj, i, j)
            force = [0, 0];
        end
        
        function applyGravity(obj)
            for n = 1:length(obj.bodies)
                for i = 1:size(obj.bodies(n).particles,1)
                    for j = 1:size(obj.bodies(n).particles,2)
                        m = obj.bodies(n).particles(i,j).mass;
                        obj.bodies(n).particles(i,j).applyForce(obj.g*m)
                    end
                end
            end
        end
        
        function update(obj,dt)
            for n = 1:length(obj.bodies)
                obj.bodies(n).update(dt)
            end
            obj.checkCollisions()
        end
        
        function plotWorld(obj)
            for n = 1:length(obj.bodies)
%                 obj.bodies(n).plotBody()
%                 hold on
                obj.bodies(n).plotBonds()
                hold on
                obj.bodies(n).plotCOM()
                hold on
                axis([0, 10, -1, 20])
            end
            hold off
        end
    end
end