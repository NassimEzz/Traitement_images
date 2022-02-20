clear
close all

% Problem setup
t_max = 100; % Max number of time steps
delta_t = 0.1; % Time stepsize
lambda = 4; % Perona-Malik parameter

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

% Initialization of the solution
I = I0;

for t = 1:t_max 
	
	% Do one diffusion step
	[I,G] = peronamalik_diffusion_step(I,Dx,Dy,lambda,delta_t);

	% Show the current result
	figure(1)
	subplot(1,3,2)
	imagesc(I,[0 255]);
	colormap gray
	axis image
	title(sprintf('Diffusion (t = %d)',t))
	drawnow
	
	subplot(1,3,3)
	imagesc(G,[0 1]);
	axis image
	title(sprintf('Diffusivity (t = %d)',t))
	drawnow
end

