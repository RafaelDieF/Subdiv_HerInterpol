% Test interpolation of point and tangents with an odd-symmetric subdivision
% scheme

clear variables
clc

%% 0. Load Dataset

% given set of points $I$, and maximum order of derivatives $(d-1)$, generate
% $U = [V0, V1, V2, ..., V{d-1}]$, such that the subdivision curve generated
% by the mask $a$ with control polygon $P$ interpolates $U$

% interpolate up to (d-1)-order derivatives
d = 1;

V = cell(d,1); 
% points
V{1} = [ -1              2    
         -2              4      
         -5/2            6      
          2              7     
          7/2            6 ];

% plot points and derivative vectors
figure
clf
hold on
plotdata(V{1})

%% 1. Subdivision mask

% Mask of the J-spline family of Odd-symmetric subdivision schemes

s = 1.5;
mask = [(s-1)/16, s/8, (9-s)/16, (4-s)/4, (9-s)/16, s/8, (s-1)/16];

%% 2. Solve the Hermite interpolation problem L * CP = U with L the 
%   interpolation operator

CP = Hinterpol(V,mask);

%% 3. Visual check of interpolation

plotSubdivCurve(CP,mask)
