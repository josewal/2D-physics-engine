classdef Particle < handle
    properties
        loc = [0,0];
        vel = [0,0];
        acc = [0,0];
        mass = 1;
    end
    
    methods
        function this = Particle()
        end
        
%         function this = Particle(m_, l_, v_, a_)
%             this.loc = l_;
%             this.vel = v_;
%             this.acc = a_;
%             this.mass = m_;
%         end
        
        function applyForce(this, force)
            this.acc = force/this.mass;
        end
        
        function update(this)
            this.vel = this.vel + this.acc;
            this.acc = [0,0];
            this.loc = this.loc + this.loc;
        end
    end
end
