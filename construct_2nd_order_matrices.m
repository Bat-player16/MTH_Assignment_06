

% modal analysis

% goal is to find M, C, and K nxn matrices
% M -> mass/intertia = Mtotal/n*I;
% C -> damping = -c/dx*Q
% K -> stiffness = 

% need to stack each motion equations on top of each other 
% then you can take out matrix Q -> Laplacian matrix



%build the mass and stiffness matrices that describe the 2nd order system.
%INPUTS
%string_params: a struct containing the system parameters describing the string
% string_params.n: number of masses
% string_params.M: total mass attached to the string
% string_params.Uf_func: function describing motion of end point
% string_params.dUfdt_func: time derivative of Uf
% string_params.Tf: %tension in string
% string_params.L: %length of string
% string_params.c: %damping coefficient
% string_params.dx: %horizontal spacing between masses
%OUTPUTS
%M_mat: the n x n mass (inertia) matrix
%K_mat: the n x n stiffness matrix
function [M_mat,K_mat] = construct_2nd_order_matrices(string_params)
    
    n = string_params.n; %number of masses
    m=string_params.M; %total mass attached to string
    m_i = m/n; % assuming each mass is equivalent
    Tf=string_params.Tf; % tension in string
    Uf_func=string_params.Uf_func; %func describing motion of end point
    dUfdt_func=string_params.dUfdt_func; % time deriv of Uf
    c=string_params.c; % damping coeff
    dx=string_params.dx; % horizontal space between masses

    % get Q matrix
    Q = construct_Laplacian(string_params);

    M_mat = m_i*eye(n);
    K_mat = -Tf/dx*Q;
end
