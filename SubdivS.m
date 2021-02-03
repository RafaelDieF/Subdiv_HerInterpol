function [sP] = SubdivS(P,k,a)
%SUBDIVS Given a mask of a linear binary subdivision scheme, subdivide the
%the polygon P with k iterations

if k>0
    if mod(size(a),2) == 1
        a = [a, 0];
    end
    
    sup = length(a)/2;
    [d1,d2] = size(P);
    sP = zeros(2*d1,d2);
    for i = 1:2*d1
        for j = 1:sup
            sP(i,:) = sP(i,:) + a(2*j-1 + mod(i-1,2))*...
                P(mod(floor((i-1)/2) - j+1 + floor((sup-1)/2), d1) + 1,:);
        end
    end    
    sP = SubdivS(sP,k-1,a);
else
    sP = P;
end

end