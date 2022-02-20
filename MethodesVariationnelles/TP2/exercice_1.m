clear
close all

% Mise en place de la figure pour affichage :
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);
figure('Name','Debruitage par variation totale',...
       'Position',[0.06*L,0.1*H,0.9*L,0.7*H]);
       
       
       
% Parametres
lambda = 0.125;			% Poids de la regularisation       
epsilon = 0.001; 		% Parametre pour garantir la differentiabilite de la variation totale :
u0 = double(imread('cameraman_avec_bruit.tif'));
critere_arret_convergence = 1e-3;



% Normalisation de l'image entre 0 et 1
u_max = max(u0(:));
u0 = u0/u_max;

% Affichage de l'image :
subplot(1,2,1)
	imagesc(max(0,min(1,u0)),[0 1])
	colormap gray
	axis image off
	title('Image bruitee','FontSize',20)   

% Affichage de l'image restauree a l'iteration 0 :
subplot(1,2,2)
	imagesc(max(0,min(1,u0)),[0 1])
	axis image off
	title('Image restauree (iteration 0)','FontSize',20)
drawnow nocallbacks



% Variables auxiliaires
[nb_lignes,nb_colonnes,nb_canaux] = size(u0);
nb_pixels = nb_lignes*nb_colonnes;

% Vectorisation de u0 :
u0 = reshape(u0,[nb_pixels 1]);

% Operateurs de differences finies 2D (cf. TP 1):
[Dx,Dy,Lap] = finite_differences_2D(nb_lignes,nb_colonnes);

% Point fixe :
u_k = u0;
u_kp1 = u0;
convergence = +Inf;
iteration = 0;

while convergence > critere_arret_convergence
	
	% Incrementation du nombre d'iterations :
	iteration = iteration + 1;
	
	% Pas de variation totale (Eq. 6)
	u_kp1 = pas_variation_totale(u0,u_k,lambda,Dx,Dy,epsilon);

	% Test de convergence :
	convergence = norm(u_kp1-u_k)/norm(u_k);
	
	% Mise a jour de l'image courante u_k :
	u_k = u_kp1;



	% Affichage de l'image restauree a chaque iteration :
	subplot(1,2,2)
		imagesc(max(0,min(1,reshape(u_k,[nb_lignes nb_colonnes]))),[0 1])
		colormap gray
		axis image off
		title(['Image restauree (iteration ' num2str(iteration) ')'],'FontSize',20)
	drawnow nocallbacks
	pause(0.2)
	
end



% Enregistrement du resultat    
imwrite(max(0,min(1,reshape(u_k,[nb_lignes nb_colonnes]))),...
        'resultat_exercice_1.png')
