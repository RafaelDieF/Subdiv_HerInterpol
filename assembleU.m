function [U] = assembleU(V, d)
%ASSEMBLEU U = [V0, V1, V2, ..., V{d-1}]

if d > size(V,1)
    U = [];
    disp('Not enough information to interpolate!')
    return;
end

n = size(V{1},1);
dim = size(V{1},2);

if d==1
    % point interpolation
    U = V{1};
elseif d==2
    % point&tangent interpolation
    U = zeros(2*n,dim);
    U(1:2:end,:) = V{1};
    U(2:2:end,:) = V{2};
elseif d==3
    % point&tangent&2nd_derivative
    U = zeros(3*n,dim);
    U(1:3:end,:) = V{1};
    U(2:3:end,:) = V{2};
    U(3:3:end,:) = V{3};
elseif d==4
    % point&tangent&2nd&3rd_derivative
    U = zeros(4*n,dim);
    U(1:4:end,:) = V{1};
    U(2:4:end,:) = V{2};
    U(3:4:end,:) = V{3};
    U(4:4:end,:) = V{4};
end
end

