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
            
            bonds(1) = Bond(obj.particles(1,1), obj.particles(1,2));
            bonds(2) = Bond(obj.particles(1,1), obj.particles(2,1));
            bonds(3) = Bond(obj.particles(1,1), obj.particles(2,2));
            bonds(4) = Bond(obj.particles(1,2), obj.particles(2,2));
            bonds(5) = Bond(obj.particles(2,1), obj.particles(2,2));
            bonds(6) = Bond(obj.particles(2,1), obj.particles(1,2));
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