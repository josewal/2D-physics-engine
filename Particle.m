classdef Particle < handle
    properties
        loc = [0 0];
        vel = [0 0];
        force = [0 0];
        mass = 10;
        isBoundry = 0;
    end
    
    methods
         function obj = Particle()
         end
        
         function set(obj, l_, v_, m_)
             obj.loc = l_;
             obj.vel = v_;
             obj.mass = m_;
         end
        
        function applyForce(obj, force)
            obj.force = obj.force + force;
        end
        
        function update(obj, dt)
            obj.vel = obj.vel + obj.force*dt/obj.mass;
            obj.force = [0 0];
            obj.loc = obj.loc + obj.vel*dt;
        end
        
        function plotParticle(obj)
            if obj.isBoundry
                plot(obj.loc(1), obj.loc(2), "ro")
            end
            
        end
    end
end
