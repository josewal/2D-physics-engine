classdef Body < handle
    properties
        com = [0,0];
        particles
        bonds
        boundries
        mass = 0;
    end
    
    methods
        function obj = Body(shape)
            obj.particles = shape.particles;
            obj.bonds = shape.bonds;
            obj.boundries = shape.boundries;
            
            for i = 1:size(obj.particles,1)
                for j = 1:size(obj.particles,2)
                    obj.mass = obj.mass + obj.particles(i,j).mass;
                end
            end
            
            obj.calcCOM();
            
        end
        
        function moveBody(obj, toWhere)
            move = toWhere - obj.com;
            for i = 1:size(obj.particles,1)
                for j = 1:size(obj.particles,2)
                    obj.particles(i,j).loc = obj.particles(i,j).loc + move;
                end
            end
        end
        
        function applyForce(obj, force)
            for i = 1:size(obj.particles,1)
                for j = 1:size(obj.particles,2)
                    obj.particles(i,j).applyForce(force)
                end
            end
        end
        
        function updateParticles(obj, dt)
            for i = 1:size(obj.particles,1)
                for j = 1:size(obj.particles,2)
                    obj.particles(i,j).update(dt)
                end
            end
        end
        
        function applyBonds(obj)
            for i = 1:size(obj.bonds,1)
                for j = 1:size(obj.bonds,2)
                    obj.bonds(i,j).applyBond()
                end
            end
        end
        
        function update(obj,dt)
            obj.applyBonds();
            obj.calcCOM();
            obj.updateParticles(dt);  
        end
        
        function calcCOM(obj)
            a = 0;
            for i = 1:size(obj.particles,1)
                for j = 1:size(obj.particles,2)
                    a = a + obj.particles(i,j).mass * obj.particles(i,j).loc;
                end
            end
            obj.com = a/obj.mass;
        end

        function plotBody(obj)
            for i = 1:size(obj.particles, 1)
                for j = 1:size(obj.particles, 2)
                    obj.particles(i,j).plotParticle()
                    hold on
                end
            end
            hold off
        end
        
        function plotBonds(obj)
            for i = 1:length(obj.bonds)
                obj.bonds(i).plotBond();
                hold on
            end
            hold off
        end
        
        function plotCOM(obj)
            plot(obj.com(1), obj.com(2), "go")
        end
        
%         function X = record(obj)
%             X = obj.com;
%             for i = 1:size(obj.boundries, 2)
%                 side = [obj.particles(obj.boundries(i,1).loc),...
%                         ...obj.particles(obj.boundries(i,2).loc)
%                 X = [X;side];
%             end
%         end
    end
end