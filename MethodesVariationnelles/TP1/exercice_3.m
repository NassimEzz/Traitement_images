clear
close all

% Problem setup
t_max = 100; % Max number of time steps
delta_t = 0.1; % Time stepsize

% Load a grayscale image
I0 = imread('lena.png'); % Load an RGB image
I0 = rgb2gray(I0); % Convert to grayscale
I0 = double(I0); % Convert to double precision

[nr,nc] = size(I0); % Problem size

figure(1)
subplot(1,3,1)
imagesc(I0,[0 255]);
colormap gray
axis image
title('Graylevel image')
drawnow

% Load finite difference matrices for this problem size
[Dx,Dy,L] = finite_differences_2D(size(I0,1),size(I0,2)); 

% Initialization of the solution at time t=0
I = I0; 

% Norm of the Laplacian at time t=0
norm_lap_I0 = norm(L*I0(:));
tab_norm_lap = [];

for t = 1:t_max 
	
	% Do one diffusion step
	I = linear_diffusion_step(I,L,delta_t);
	
	% Compute the norm of the Laplacian at current iteration
	tab_norm_lap = [tab_norm_lap norm(L*I(:))/norm_lap_I0];
	
	% Show the current result
	figure(1)
	subplot(1,3,2)
	imagesc(I,[0 255]);
	colormap gray
	axis image
	title(sprintf('Diffusion (t = %d)',t))
	drawnow
	
	subplot(1,3,3)
	plot(1:t,tab_norm_lap) 
	axis tight
	xlabel('Iterations','Interpreter','Latex','Fontsize',14)
	ylabel('$$\frac{\left\| \Delta u \right\|}{\left\| \Delta u_0 \right\|}$$','Interpreter','Latex','Fontsize',14)
	title('Laplacian evolution')
	
end

