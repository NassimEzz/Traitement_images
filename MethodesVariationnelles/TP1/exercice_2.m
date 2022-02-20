clear
close all

% Load a grayscale image
I = imread('lena.png'); % Load an RGB image
I = rgb2gray(I); % Convert to grayscale
I = double(I); % Convert to double precision

[nr,nc] = size(I); % Problem size

figure(1)
imagesc(I);
axis image
colormap gray
colorbar
title('Graylevel image')
drawnow

% Finite differences operators
[Dx,Dy,L] = finite_differences_2D(nr,nc); 

% Compute image derivatives and norm of the gradient
[Ix,Iy,Idelta,Ig] = image_derivatives(I,Dx,Dy,L);

% Compare our gradient with Matlab's
[Ix_Matlab,Iy_Matlab] = imgradientxy(I,'intermediate'); 
Ig_Matlab = imgradient(I,'intermediate');
Idelta_Matlab = 4*del2(I);

figure(2) 
subplot(2,4,1)
imagesc(Ix_Matlab,[-20 20]); 
axis image
colorbar
title('$$I_x$$ (Matlab)','Interpreter','Latex','Fontsize',18)
subplot(2,4,2)
imagesc(Iy_Matlab,[-20 20]); 
axis image
colorbar
title('$$I_y$$ (Matlab)','Interpreter','Latex','Fontsize',18)
subplot(2,4,3)
imagesc(Ig_Matlab,[0 20]); 
axis image
colorbar
title('$$\left\|\nabla I\right\|$$ (Matlab)','Interpreter','Latex','Fontsize',18)
subplot(2,4,4)
imagesc(Idelta_Matlab,[-20 20]); 
axis image
colorbar
title('$$\Delta I$$ (Matlab)','Interpreter','Latex','Fontsize',18)

subplot(2,4,5)
imagesc(Ix,[-20 20]); 
axis image
colorbar
title('$$I_x$$ (Ours)','Interpreter','Latex','Fontsize',18)
subplot(2,4,6)
imagesc(Iy,[-20 20]); 
axis image
colorbar
title('$$I_y$$ (Ours)','Interpreter','Latex','Fontsize',18)
subplot(2,4,7)
imagesc(Ig,[0 20]); 
axis image
colorbar
title('$$\left\|\nabla I\right\|$$ (Ours)','Interpreter','Latex','Fontsize',18)
subplot(2,4,8)
imagesc(Idelta,[-20 20]); 
axis image
colorbar
title('$$\Delta I$$ (Ours)','Interpreter','Latex','Fontsize',18)
drawnow


