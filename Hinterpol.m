function [CP , mask] = Hinterpol(V,mask,sp)
% HINTERPOL  Interpolate a set of points and associated derivative vectors
% with a scalar subdivision scheme defined by the mask a, the interpolation
% occurs at parameters defined by a shift of integer values with the
% argument shiftpar
%
%   [CP, mask] = Hinterpol(U)  interpolate info in U
%
%   [CP, mask] = Hinterpol(U, mask)  interpolate info in U with the subdivision
%                              scheme defined by that mask
%
%   [CP, mask] = Hinterpol(U, mask, sp)  interpolate info in U with the subdivision
%                                 scheme defined by that mask at shifted parameters
%
%   INPUT:
%
%   U           cell of points and associate derivatives vectors. U{k} returns
%   the (k-1)-th derivative vectors associated to the points in U{1}.
%
%   mask        subdivision mask of a scalar linear uniform subdivision scheme
%
%   shiftpar    the subdivision curve c(t) interpolate the data at integer
%   parameters shifted by shiftpar, i.e.,
%               d^(k) c(j + shifpar) / d t^k = U{k}(j)
%
%   OUTPUT:
%
%   CP  return control points defining the interpolating subdivision curve
%
%   mask return the subdivision mask used, in case of not declared as input,
%   it is provided the one used by default
%

if  ~iscell(V)
    temp{1} = V;
    V = temp;
end
% interpolate till der-th order derivatives
der = length(V);
% amount of interpolated points
n = size(V{1},1);

% validate the interpolation operator for the subdivision scheme
if (length(mask)-2) > n
    warning('Provide more control points to be interpolated');
    CP = [];
    return
end

U = assembleU(V,der);

% subdivision mask by default
if nargin < 2
    % cubic B-spline subdivision mask
    mask = [1/8 1/2 6/8 1/2 1/8];
end

%% Computing the sampling of the basic function by eigenanalysis
ns = 2;

if (der==1) || (der==2)
    if nargin < 3
        % default choice for stencil
        if (mod(length(mask),2) == 0) && (der == 1)
            % use an even ns
            ns = ns + mod(ns,2);
            sp = ns/2;
        elseif (mod(length(mask),2) == 1) && (der == 2)
            % use an even ns
            ns = ns + mod(ns,2);
            sp = ns/2;
        else
            sp = ns;
        end
    end
end

stencils = limitstencils(mask,ns,sp);

stencil = stencils{1}';
if der > 1
    stencilder = stencils{2}';
end

%% Defining the Interpolation operator at shifted parameters

Ls = length(stencil);
sup = ceil(Ls/2);

if der == 1
    blockvect = [stencil(sup:-1:1), zeros(1,n-Ls), stencil(end:-1:sup+1)];
elseif der == 2
    blockvect = [stencil(sup:-1:1), zeros(1,2*n-Ls), stencil(end:-1:sup+1);
        stencilder(sup:-1:1), zeros(1,2*n-Ls), stencilder(end:-1:sup+1)];
else
    warning('Not defined yet')
end

%% Computing the control points that solve the interpolation problem 

% filter that defines L = real(kron(F,eye(d))*diag(filt)*kron(F',eye(d))) 
T = sqrt(n)*blockIFFT(blockvect',der)';

% filter that defines M^{-1}
filt = zeros(size(T));
for j = 1:n
    % pseudoinverse of each dxd block
    filt(:,der*(j-1)+1:der*j) = pinv(T(:,der*(j-1)+1:der*j));
end

CP = real(blockFFT(blockfilter(filt,blockIFFT(U,der)),der));

end
