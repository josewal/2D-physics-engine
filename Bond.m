classdef Bond < handle
    properties
        A
        B
        Ks = 5;
        Kd = 5;
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
            diff =   norm(locDiff);
            pointer = (locDiff/diff);
            
            fs  =   (diff - obj.L0) * obj.Ks;
            fd  =   dot(pointer, velDiff) * obj.Kd;
            f   =   (fs + fd)*pointer;
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