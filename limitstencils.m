function [ stencils ] = limitstencils( mask,n,q )
%   LIMITSTENCILS: compute the limit stencils (sampling of basic function at
%   integer shifts of n-adic points) for a subdivision scheme with
%   specified mask
%     
%   INPUT:
%    a: subdivision mask
%    n: generate sampling of basic function at f(Z/n)
%    q: to return sampling of basic function at f(Z + q/n), 0<q<n+1
%    
%   OUTPUT:
%    stencils: cell with the stencil for each derivative

if nargin < 3
    q = n;
end
if q > n
    warning('Parameter q > n, therefore q = n')
    q = n;
end
if nargin < 2
    n = 1;
end

La = length(mask);
sup = ceil(La/2);

% matrix of the system of equations S*Phi = Phi which unknowns are
% the values of basic function at n-adic points
S = zeros((La - 1)*n+1);

% fill the matrices
for r = 1:(La-1)*n+1
    for c = 1:La % upsampling "a" by "n" and shift by "c"
        if (2*r-(La-c)*n-1 > 0)&&(2*r-(La-c)*n-1 < (La-1)*n+2)
            S(r,2*r-(La-c)*n-1) = mask(c);
        end
    end
end

D = 2*S;

% solve the system (S-I)*Phi = 0
S = S - eye((La-1)*n+1);
D = D - eye((La-1)*n+1);

% add partition of unity restriction
S(end+1:end+n,:) = [kron(ones(1,La-1),eye(n)), [1;zeros(n-1,1)]];

D(end+1:end+n,:) = zeros(n,(La-1)*n+1);
for r = (La-1)*n+2:La*n+1
    for c = 0:La-2
        D(r, r- (La-1)*n-1 + c*n) = -((r- (La-1)*n-2)/n + c-sup+1);
    end
end
D((La-1)*n+2,(La-1)*n+1) = -sup+1;

v = [zeros((La-1)*n+1,1);ones(n,1)];

% sampling of basic function at n-adic points
x = linsolve(S,v);
x = x(2:end-1);
% sampling of basic function first derivative at n-adic points
y = linsolve(D,v);
y = y(2:end-1);

% stencils of limit points at parameters Z/n + q/n
stencils{1} = x(q:n:end);
stencils{2} = y(q:n:end);

end
