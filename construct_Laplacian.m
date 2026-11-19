% creates the laplacian matrix Q

function [Q] = construct_Laplacian(string_params)
    n = string_params.n; % number of masses
    I_n = eye(n);

    % now need to add -2, 1, 0 pattern in 
    Q = -2*I_n + circshift(I_n,[0,1]) + circshift(I_n,[0,-1]);

    % now need to remove top right and bottom left 1s
    Q(1, end) = Q(1,end) - 1;
    Q(end, 1) = Q(end,1)-1;
end