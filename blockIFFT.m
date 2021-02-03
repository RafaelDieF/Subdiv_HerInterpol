function [V] = blockIFFT(U,d)
%BLOCKIFFT V = kron(F_n',eye(d))*U_{n*d}
%   F_n the Discrete Fourier Transform: F_n'*u = ifft(u)*sqrt(n)

if nargin < 2
    d = 1;
end
% designed for vertical block-vectors
n = size(U,1)/d;
dim = size(U,2);

if d == 1
    V = ifft(U)*sqrt(n);
else
    V = nan(size(U));
    for i=1:dim
        V(:,i) = reshape(ifft(reshape(U(:,i),d,[]),n,2),[],1)*sqrt(n);        
    end
end

end