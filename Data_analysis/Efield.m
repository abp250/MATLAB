%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A demo program for EE468 to show distribution of potential function.
% This programp plots the potential of 3 point charges
% To simplify the plotting and singular points: Samples can
% not be on the position of any charges
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
e0=8.854e-12;                 % Permittivity of free-space
q1= 100e-9; r1=[-4 0 0 ];       % Point charge-1 and its position
q2=-100e-9; r2=[ 4 0 0 ];       % Point charge-2 and its position
q3=-20e-9; r3=[ 0 4 0 ];       % Point charge-3 and its position

c1=q1/(4*pi*e0);              % The constant :  Q/(4*pi*epsilon0)
c2=q2/(4*pi*e0);
c3=q3/(4*pi*e0);

x=-3.0:0.05:3.0;              % Samples along x-direction
y=-3.0:0.05:3.0;              % Samples along y-direction

nx=max(size(x));              % Number of samples in x
ny=max(size(y));              % Number of samples in y

for ix = 1:1:nx               % Loop over the samples to evaluate V(x,y)
for iy = 1:1:ny
  r = [x(ix) y(iy) 0.0];      % The source point( x', y', z'=0)
  d1=sqrt( (r-r1)*(r-r1)');   % Distance of r' to r1
  d2=sqrt( (r-r2)*(r-r2)');
  d3=sqrt( (r-r3)*(r-r3)');
  v(ix,iy) = c1/d1+c2/d2+c3/d3;   % Summation of potentials
end;
end;

% To plot the contour:
figure(1); clf; contour(x,y,v',60); 
xlabel('X-AXIS');ylabel('Y-AXIS');

% To plot in 3D mesh
figure(2); clf; mesh(x,y,v'); view(60,20); 
xlabel('X-AXIS');ylabel('Y-AXIS');

% To plot in color scaled image:
v1=min(min(v));                   % Minimum of V for normalization
v2=max(max(v));                   % Maximum of V
m0=max(size(colormap));           % Number of colors
vn = (m0-1)*(v-v1)/(v2-v1);       % Normalized so that V is from 0 to m0-1
figure(3); clf;
image(x,y,vn');

% To plot E-field
[Ex,Ey] = gradient(v,0.1,0.1);
Ex=-Ex; Ey=-Ey;
figure(4); clf;
quiver(x,y,Ex,Ey,2);
