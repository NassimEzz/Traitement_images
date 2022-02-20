function u_kp1 = pas_variation_totale(u0,u_k,lambda,Dx,Dy,epsilon)
% INPUTS: 
%   u0 (n x 1)      : signal a debruite
%   u_k (n x 1)     : signal debruite a l'iteration k 
%   lambda (1 x 1)  : parametre de regularisation 
%   Dx (n x n)      : operateur de differences finies horizontales
%   Dy (n x n)      : operateur de differences finies verticales
%   epsilon (1 x 1) : regularisation de la valeur absolue pour eviter les divisions par zero
%
% OUTPUTS:
%   u_kp1 (n x 1)   : signal debruite a l'iteration k+1

    FX = Dx*u_k;
    FY = Dy*u_k;
    gradient_abs = FX.*FX + FY.*FY;
    den = gradient_abs + epsilon;
    diag = 1 ./ sqrt(den);
    
    n = size(u_k);
    Wk = spdiags(diag, 0, n(1), n(1));
    div = -Dx'*Wk*Dx - Dy'*Wk*Dy;
    
    A = speye(n(1)) - lambda*div;
    
    u_kp1 = pcg(A,u0);
    
end
