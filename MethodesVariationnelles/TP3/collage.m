function u = collage(r,s,interieur)

% Conversion au format double :
r = double(r);
s = double(s);

% Dimensions de r :
[nb_lignes_r,nb_colonnes_r,nb_canaux] = size(r);

% Calcul de l'imagette resultat im, canal par canal :
N = nb_lignes_r * nb_colonnes_r;
u = r;
[~, ~, A] = finite_differences_2D(nb_lignes_r, nb_colonnes_r);
I = speye(N, N);

r_bord = zeros(nb_lignes_r, nb_colonnes_r);
r_bord(1,1:end) = 1;
r_bord(2:end-1,1) = 1;
r_bord(end,1:end) = 1;
r_bord(2:end-1,end) = 1;

indices_Omega_1 = find(r_bord);
A(indices_Omega_1,:) = I(indices_Omega_1,:);

indices_Omega_3 = interieur;
    
[nb_lignes_s,nb_colonnes_s,nb_canaux_s] = size(s);

for k = 1:nb_canaux
    sk = s(:,:,k)
    sk_flattened = reshape(sk, [nb_lignes_s * nb_colonnes_s, 1]);
    [Dx, Dy, ~] = finite_differences_2D(nb_lignes_s, nb_colonnes_s);
    gradient_s_x = Dx*sk_flattened;
    gradient_s_y = Dy*sk_flattened;

    rk = r(:,:,k);
    rk_flattened = reshape(rk, [N, 1]);
    [Dx, Dy, ~] = finite_differences_2D(nb_lignes_r, nb_colonnes_r);
    gradient_r_x = Dx*rk_flattened;
    gradient_r_y = Dy*rk_flattened;

    g_x = zeros(N, 1);
    g_y = zeros(N, 1);

    g_x = gradient_r_x;
    g_y = gradient_r_y;

    g_x(indices_Omega_3) = gradient_s_x(indices_Omega_3);
    g_y(indices_Omega_3) = gradient_s_y(indices_Omega_3);
    
    g_x(indices_Omega_1) = 0;
    g_y(indices_Omega_1) = 0;
    
    div_g = Dx*g_x + Dy*g_y;
    
    bk = zeros(nb_lignes_r * nb_colonnes_r, 1);
    bk = div_g;
    
    bk(indices_Omega_1) = rk_flattened(indices_Omega_1);
    
    u(:,:,k) = reshape(A\bk, [nb_lignes_r, nb_colonnes_r]);
end


