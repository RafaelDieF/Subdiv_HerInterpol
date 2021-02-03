function [] = plotSubdivCurve(CP, mask, iter)
%PLOTSUBDIVCURVE Plot the subdivision curve defined by the mask with
%control points CP after specified amount of iterations

if nargin < 3
    iter = 5;
end

% use vertical matrix of data points
if size(CP,1) < size(CP,2)
    CP = CP';
end

SP = SubdivS(CP,iter,mask);

if size(CP,2) == 3
    plot3([SP(:,1);SP(1,1)],[SP(:,2);SP(1,2)],...
        [SP(:,3);SP(1,3)],'r-','LineWidth',1.2)
else
    plot([SP(:,1);SP(1,1)],[SP(:,2);SP(1,2)],'r-','LineWidth',1.2)
end

end
