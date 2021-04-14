classdef Body < handle
    properties
        com = [0,0];
        particles
        bonds
        mass = 0.1;
        
    end
    
    methods
        function obj = Body(size, shape)
            for i = 1:size(1)
                for j = 1:size(2)
                    particles(i,j) = Particle();
                    particles(i,j).set([shape(i,2*j-1), shape(i,2*j)], [0,0], 1)
                    obj.mass = obj.mass + particles(i,j).mass;
                end
            end
            obj.particles = particles;
            
            bonds(1) = Bond(obj.particles(1,1), obj.particles(1,2), 1);
            bonds(2) = Bond(obj.particles(1,1), obj.particles(2,1), 1);
            bonds(3) = Bond(obj.particles(1,1), obj.particles(2,2), 1.4);
            bonds(4) = Bond(obj.particles(1,2), obj.particles(2,2), 1);
            bonds(5) = Bond(obj.particles(2,1), obj.particles(2,2), 1);
            bonds(6) = Bond(obj.particles(2,1), obj.particles(1,2), 1.4);
            bonds(7) = Bond(obj.particles(3,1), obj.particles(3,2), 1);
            bonds(8) = Bond(obj.particles(3,2), obj.particles(2,2), 1);
            bonds(9) = Bond(obj.particles(3,1), obj.particles(2,1), 1);
            bonds(10) = Bond(obj.particles(3,1), obj.particles(2,2), 1.4);
            bonds(11) = Bond(obj.particles(3,2), obj.particles(2,1), 1.4);
            
            bonds(12) = Bond(obj.particles(3,1), obj.particles(4,1), 1)
            ;
            bonds(13) = Bond(obj.particles(3,1), obj.particles(4,2), 1.4);
            bonds(14) = Bond(obj.particles(3,2), obj.particles(4,1), 1.4);
            bonds(15) = Bond(obj.particles(3,2), obj.particles(4,2), 1);
            bonds(16) = Bond(obj.particles(4,1), obj.particles(4,2), 1);
            
            bonds(17) = Bond(obj.particles(1,2), obj.particles(1,3), 1);
            bonds(18) = Bond(obj.particles(1,2), obj.particles(2,3), 1.4);
            bonds(19) = Bond(obj.particles(1,3), obj.particles(2,3), 1);
            bonds(20) = Bond(obj.particles(1,3), obj.particles(2,2), 1.4);
            
            bonds(21) = Bond(obj.particles(2,2), obj.particles(2,3), 1);
            bonds(22) = Bond(obj.particles(2,2), obj.particles(3,3), 1.4);
            bonds(23) = Bond(obj.particles(2,3), obj.particles(3,3), 1);
            bonds(24) = Bond(obj.particles(2,3), obj.particles(3,2), 1.4);
            
            bonds(25) = Bond(obj.particles(3,2), obj.particles(3,3), 1);
            bonds(26) = Bond(obj.particles(3,2), obj.particles(4,3), 1.4);
            bonds(27) = Bond(obj.particles(3,3), obj.particles(4,3), 1);
            bonds(28) = Bond(obj.particles(3,3), obj.particles(4,2), 1.4);
            
            bonds(29) = Bond(obj.particles(4,2), obj.particles(4,3), 1);
            
            obj.bonds = bonds;
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
    end
end