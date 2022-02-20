function [I,G] = linear_diffusion_step(I,Dx,Dy,lambda,delta_t)
% INPUTS
%    I(nr x nc): image at time t
%    Dx, Dy(nr.nc x nr.nc): matrices approximating the gradient operator
%    lambda (1 x 1): smoothing parameter
%    delta_t(1 x 1): stepsize
% OUTPUTS
%    I(nr x nc): image at time t+1
%    G(nr x nc): diffusivity map at time t


end
