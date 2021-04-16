classdef ShapeConstructor < handle
    properties
        particles
        bonds
        
        particleMap
        model
        boundries
    end
    
    methods
        function obj = ShapeConstructor(model_, dL, Ks, Kd)
            obj.model = rot90(model_,-1);
            obj.skeletonize(dL, Ks, Kd);
        end
        
        
        function bool = isThere(obj, i, j)
            if (i < 1) || (j < 1) || (i > size(obj.model,1)) || (j > size(obj.model,2))
                bool = 0;
            else
                bool = obj.model(i,j);
            end
        end
        
        
        function particle = newParticle(obj,i,j)
            particle = Particle();
            particle.set([i,j], [0,0], 1);
        end
        
        function [n,m] = decodePos(obj, i)
            p = obj.particlesList(i);
            l = size(obj.model, 2)+1;
            n = floor((p-1)/l);
            m = mod(p-1,l) + 1;
        end
        
        function [p] = encodePos(obj, i, j)
            p = i*(size(obj.model,2)+1)+j;
        end
        
        function findBoundries(obj)
            n = 0;
            for i = 1:size(obj.model,1) 
                for j = 1:size(obj.model,2)+1
                    if obj.isThere(i,j)
                        if ~obj.isThere(i, j-1)
                            n = n+1;
                            iA = obj.particleMap(obj.encodePos(i,j));
                            iB = obj.particleMap(obj.encodePos(i+1,j));
                            obj.boundries(n,1) = iA;
                            obj.boundries(n,2) = iB;
                            
                            obj.particles(iA).isBoundry = 1;
                            obj.particles(iB).isBoundry = 1;
                        end
                        if ~obj.isThere(i-1, j)
                            n = n+1;
                            iA = obj.particleMap(obj.encodePos(i,j));
                            iB = obj.particleMap(obj.encodePos(i,j+1));
                            obj.boundries(n,1) = iA;
                            obj.boundries(n,2) = iB;
                            
                            obj.particles(iA).isBoundry = 1;
                            obj.particles(iB).isBoundry = 1;
                        end
                        if ~obj.isThere(i, j+1)
                            n = n+1;
                            iA = obj.particleMap(obj.encodePos(i,j+1));
                            iB = obj.particleMap(obj.encodePos(i+1,j+1));
                            obj.boundries(n,1) = iA;
                            obj.boundries(n,2) = iB;
                            
                            obj.particles(iA).isBoundry = 1;
                            obj.particles(iB).isBoundry = 1;
                        end
                        if ~obj.isThere(i+1, j)
                            n = n+1;
                            iA = obj.particleMap(obj.encodePos(i+1,j));
                            iB = obj.particleMap(obj.encodePos(i+1,j+1));
                            obj.boundries(n,1) = iA;
                            obj.boundries(n,2) = iB;
                            
                            obj.particles(iA).isBoundry = 1;
                            obj.particles(iB).isBoundry = 1;
                        end
                    end
                end
            end
        end
        
        function skeleton = skeletonize(obj, dL, Ks, Kd)
            n = 0;
            m = 0;
            
            obj.particleMap = containers.Map('KeyType','double','ValueType','double');
            
            for i = 1:size(obj.model,1)
                for j = 1:size(obj.model,2)+1
                    if ~obj.isThere(i,j)
                        if obj.isThere(i,j-1)
                            n = n + 1;
                            particles_(n) = obj.newParticle(i+1,j);
                            obj.particleMap(obj.encodePos(i+1,j)) = n;
                            
                            m = m + 1;
                            iB = obj.particleMap(obj.encodePos(i,j));
                            bonds_(m) = Bond(particles_(n), particles_(iB), 1, dL, Ks, Kd);
                        end
                    else
                        if ~obj.isThere(i,j-1) && ~obj.isThere(i-1, j-1) && ~obj.isThere(i-1,j)
                            n = n + 1;
                            particles_(n) = obj.newParticle(i,j);
                            obj.particleMap(obj.encodePos(i,j)) = n;
                        end
                        
                        if ~obj.isThere(i-1, j+1) && ~obj.isThere(i-1,j)
                            n = n + 1;
                            particles_(n) = obj.newParticle(i,j+1);
                            obj.particleMap(obj.encodePos(i,j+1)) = n;
                        end
                        
                        n = n + 1;
                        particles_(n) = obj.newParticle(i+1,j);
                        obj.particleMap(obj.encodePos(i+1,j)) = n;
                        
                        if ~obj.isThere(i-1,j)
                            m = m + 1;
                            iA = obj.particleMap(obj.encodePos(i,j));
                            iB = obj.particleMap(obj.encodePos(i,j+1));
                            bonds_(m) = Bond(particles_(iA), particles_(iB), 1, dL, Ks, Kd);
                        end
                        
                        m = m + 1;
                        iA = obj.particleMap(obj.encodePos(i,j));
                        iB = obj.particleMap(obj.encodePos(i+1,j));
                        bonds_(m) = Bond(particles_(iA), particles_(iB), 1, dL, Ks, Kd);
                        
                        m = m + 1;
                        iA = obj.particleMap(obj.encodePos(i+1,j));
                        iB = obj.particleMap(obj.encodePos(i,j+1));
                        bonds_(m) = Bond(particles_(iA), particles_(iB), 1.41, dL, Ks, Kd);
                    end
                    if obj.isThere(i,j-1)
                        m = m + 1;
                        iA = obj.particleMap(obj.encodePos(i+1,j));
                        iB = obj.particleMap(obj.encodePos(i+1,j-1));
                        bonds_(m) = Bond(particles_(iA), particles_(iB), 1, dL, Ks, Kd);
                        
                        m = m + 1;
                        iA = obj.particleMap(obj.encodePos(i+1,j));
                        iB = obj.particleMap(obj.encodePos(i,j-1));
                        bonds_(m) = Bond(particles_(iA), particles_(iB), 1.41, dL, Ks, Kd);
                    end
                end
                
            end
            if n > 0
                obj.particles = particles_;
                obj.bonds = bonds_;
                obj.findBoundries();
            end
        end
        
    end
    
end