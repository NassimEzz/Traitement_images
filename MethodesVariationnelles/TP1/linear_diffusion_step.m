function I = linear_diffusion_step(I,L,delta_t)
% INPUTS
%    I(nr x nc): image at time t
%    L(nr.nc x nr.nc): matrix approximating the Laplacian
%    delta_t(1 x 1): stepsize
% OUTPUTS
%    I(nr x nc): image at time t+1

    nr = size(I,1);
    nc = size(I,2);
    
    M = eye(nr*nc, nr*nc) - delta_t.*L;
    I = M\I;
    
end
