% Test interpolation of point and tangents with an even-symmetric subdivision
% scheme

clear variables
clc

%% 0. Load Dataset

% given set of points $I$, and maximum order of derivatives $(d-1)$, generate
% $U = [V0, V1, V2, ..., V{d-1}]$, such that the subdivision curve generated
% by the mask $a$ with control polygon $P$ interpolates $U$

% interpolate up to (d-1)-order derivatives
d = 2;

V = cell(d,1); 
% points
V{1} = [ -9    0
         -9    2.4
          9    2.4
          9    0
          5    0
          5    1
          0    1.2
         -5    1
         -5    0 ];
% associated tangents
V{2} = [-2.1593    0.7360
         5.4847    0.8233
         5.4847   -0.8233
        -2.1593   -0.7360
        -0.7958    0.4064
        -1.0234    0.3338
        -3.0120         0
        -1.0234   -0.3338
        -0.7958   -0.4064];
 
% plot points and derivative vectors
figure
clf
hold on
plotdata(V{1}, V{2})

%% 1. Subdivision mask

% Mask of the Dyn-Floater-Hormann family of Even-symmetric subdivision schemes

s = 1/128;
mask = [-5*s/8, -7*s/8, (3*s + 2)/8, (9*s + 6)/8, (9*s + 6)/8, (3*s + 2)/8, -7*s/8, -5*s/8];


%% 2. Solve the Hermite interpolation problem L * CP = U with L the 
%   interpolation operator

CP = Hinterpol(V,mask);

%% 3. Visual check of interpolation

plotSubdivCurve(CP,mask)
