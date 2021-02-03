function [fU] = blockfilter(filt,U)
%BLOCKFILTER  filt in R^{d,n*d}, U in R^{n*d,s},
% fU_{t} = filt_{:,t}*U_{t,:}, t=1:n, where fU_{t} are d-blocks 
% if d==1 it's equivalent to fU = filt.*U

% designed for vertical block-vectors
d = size(filt,1);
n = size(filt,2)/d;
% validate input
if ~size(U,1)== size(filt,2)
    fU = [];
    return;
end

fU = nan(size(U));
for i = 1:n
    fU((i-1)*d+1:i*d,:) = filt(:,(i-1)*d+1:i*d)*U((i-1)*d+1:i*d,:);
end

end