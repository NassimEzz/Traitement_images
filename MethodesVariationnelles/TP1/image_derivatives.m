function [Ix,Iy,Idelta,Ig] = image_derivatives(I,Dx,Dy,L)
% INPUTS
%    I (nr x nc): double-precision image
%    Dx(nr.nc x nr.nc): matrix approximating differentiation in the horizontal direction
%    Dy(nr.nc x nr.nc): matrix approximating differentiation in the vertical direction
%    L(nr.nc x nr.nc): matrix approximating the Laplacian
% OUTPUTS
%    Ix (nr x nc): image of the x-derivative of I
%    Iy (nr x nc): image of the y-derivative of I
%    Idelta (nr x nc): image of the laplacian of I
%    Ig (nr x nc): image of the norm of the gradient of I

    u = I(:);
    ux = Dx*u;
    uy = Dy*u;
    udelta = L*u;
    
    nrnc = size(I);
    nr = nrnc(1);
    nc = nrnc(2);
    
    Ix = reshape(ux, nr, nc);
    Iy = reshape(uy, nr, nc);
    Idelta = reshape(udelta, nr, nc);
    Ig = sqrt(Ix.*Ix + Iy.*Iy);
    
end
