classdef Particle < handle
    properties
        loc = [0; 0];
        vel = [0; 0];
        acc = [0; 0];
        mass = 1;
    end
    
    methods
         function obj = Particle()
         end
        
         function set(obj, l_, v_, m_)
             obj.loc = l_;
             obj.vel = v_;
             obj.acc = [0,0];
             obj.mass = m_;
         end
        
        function applyForce(obj, force)
            obj.acc = force/obj.mass;
        end
        
        function update(obj)
            obj.vel = obj.vel + obj.acc;
            obj.acc = [0,0];
            obj.loc = obj.loc + obj.vel;
        end
    end
end
