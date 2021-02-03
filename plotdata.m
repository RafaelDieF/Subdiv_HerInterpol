function [] = plotdata(varargin)
%PLOTV plot points and derivative vectors

d = nargin;

V0 = varargin{1};
[n,dim] = size(V0);

% interpolated data: limit points
if (dim==3)
    plot3([V0(1:end,1);V0(1,1)],[V0(1:end,2);V0(1,2)],[V0(1:end,3);V0(1,3)],'bo-','MarkerFaceColor','b')
else
    plot([V0(1:end,1);V0(1,1)],[V0(1:end,2);V0(1,2)],'bo-','MarkerFaceColor','b')
end

if d>1
    V1 = varargin{2};
    % plot limit tangents: first derivatives
    for i=1:n
        if (dim==3)
            plot3([V0(i,1),V0(i,1)+V1(i,1)], [V0(i,2),V0(i,2)+V1(i,2)], ...
                [V0(i,3),V0(i,3)+V1(i,3)],'g-','LineWidth',1.5)
        else
            plot([V0(i,1),V0(i,1)+V1(i,1)], [V0(i,2),V0(i,2)+V1(i,2)], ...
                'g-','LineWidth',1.5)
        end
    end
end
if d>2
    V2 = varargin{3};
    % plot limit second derivatives
    for i=1:n
        if (dim==3)
            plot3([V0(i,1),V0(i,1)+V2(i,1)], [V0(i,2),V0(i,2)+V2(i,2)], ...
                [V0(i,3),V0(i,3)+V2(i,3)],'m-','LineWidth',1.5)
        else
            plot([V0(i,1),V0(i,1)+V2(i,1)], [V0(i,2),V0(i,2)+V2(i,2)], ...
                'm-','LineWidth',1.5)
        end
    end
end
if d>3
    V3 = varargin{4};
    % plot limit third derivatives
    for i=1:n
        if (dim==3)
            plot3([V0(i,1),V0(i,1)+V3(i,1)], [V0(i,2),V0(i,2)+V3(i,2)], ...
                [V0(i,3),V0(i,3)+2*V3(i,3)],'k-','LineWidth',2.5)
        else
            plot([V0(i,1),V0(i,1)+V3(i,1)], [V0(i,2),V0(i,2)+V3(i,2)], ...
                'k-','LineWidth',1.5)
        end
    end
end

end