function [V] = blockFFT(U,d)
%BLOCKFFT V = kron(F_n,eye(d))*U_{n*d}
%   F_n the Discrete Fourier Transform: F_n*u = fft(u)/sqrt(n)

if nargin < 2
    d = 1;
end
n = size(U,1)/d;
dim = size(U,2);

if d == 1
    V = fft(U)/sqrt(n);
else
    V = nan(size(U));
    for i=1:dim
        V(:,i) = reshape(fft(reshape(U(:,i),d,[]),n,2),[],1)/sqrt(n);        
    end
end

end