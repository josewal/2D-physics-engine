classdef Bond < handle
    properties
        A
        B
        Ks = 700;
        Kd = 10;
        L0 = 0.5
        Lmin = 0.4;
        Lmax = 0.6;
        dL = 0.2;
    end
    
    methods
        function obj = Bond(A_, B_, L0_, dL_, Ks_, Kd_)
            obj.A = A_;
            obj.B = B_;
            obj.L0 = L0_;
            obj.Lmin = L0_*(1-obj.dL);
            obj.Lmax = L0_*(1+obj.dL);
            obj.Ks = Ks_;
            obj.dL = dL_;
            obj.Kd = Kd_;
            
        end
        
        function f = calcForce(obj)
            locDiff =   obj.B.loc - obj.A.loc;
            velDiff =   obj.B.vel - obj.A.vel;
            L =         norm(locDiff);
            if L ~= 0
                pointer =   (locDiff/L);
                if L < obj.Lmin
                    Ldiff = obj.Lmin - L;
                    a = Ldiff*pointer;
                    obj.B.loc = obj.B.loc + a/2;
                    obj.A.loc = obj.A.loc - a/2;
                    
                    obj.B.vel = obj.B.vel - velDiff/1.01;
                    obj.A.vel = obj.A.vel + velDiff/1.01;
                    
                    L = obj.Lmin;
                elseif L  > obj.Lmax
                    Ldiff = obj.Lmax - L;
                    a = Ldiff*pointer;
                    obj.B.loc = obj.B.loc + a/2;
                    obj.A.loc = obj.A.loc - a/2;
                    %                 L = obj.Lmax;
                end
                fs  =   (L - obj.L0) * obj.Ks;
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
            if obj.A.isBoundry && obj.B.isBoundry && (obj.L0 ~= 1.41)
                plot([obj.A.loc(1), obj.B.loc(1)], [obj.A.loc(2), obj.B.loc(2)], "b-", "LineWidth", 3)
%             else
%                 plot([obj.A.loc(1), obj.B.loc(1)], [obj.A.loc(2), obj.B.loc(2)], "r-", "LineWidth", 2)
            end
        end
    end
end