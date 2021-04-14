classdef Bond < handle
    properties
        A
        B
        Ks = 300;
        Kd = 3;
        L0 = 1;
    end
    
    methods
        function obj = Bond(A_, B_)
            obj.A = A_;
            obj.B = B_;
        end
        
        function f = calcForce(obj)
            locDiff =   obj.B.loc - obj.A.loc;
            velDiff =   obj.B.vel - obj.A.vel;
            L =         norm(locDiff);
            if L ~= 0
                pointer =   (locDiff/L);
                fs  =   (L - obj.L0)^3 * obj.Ks;
                fd  =   dot(pointer, velDiff) * obj.Kd;
                f   =   (fs + fd)*pointer;
            else
                f = [0,0];
            end     
        end
        
        function applyBond(obj)
            force = obj.calcForce();
            obj.A.applyForce(force);
            obj.B.applyForce(-force);
        end
        
        
        function plotBond(obj)
            plot([obj.A.loc(1), obj.B.loc(1)], [obj.A.loc(2), obj.B.loc(2)], "b-")
        end
    end
end