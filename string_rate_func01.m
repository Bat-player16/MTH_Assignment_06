% t_in: current time
% V_in: current system state
function [V_out] = string_rate_func01(t_in,V_in,string_params)

n = string_params.n; %number of masses
m=string_params.M; %total mass attached to string
m_i = m/n; % assuming each mass is equivalent
Tf=string_params.Tf; % tension in string
Uf_func=string_params.Uf_func; %func describing motion of end point
dUfdt_func=string_params.dUfdt_func; % time deriv of Uf
c=string_params.c; % damping coeff
dx=string_params.dx; % horizontal space between masses

%unpack state variable
U = V_in(1:n); % getting first column which should be U
dUdt = V_in((n+1):(2*n)); %

% Uf is actuator, get displacement and velocity
Uf = Uf_func(t_in);
dUfdt = dUfdt_func(t_in);
U_with_boundaries = [0; U; Uf];
dUdt_with_boundaries = [0; dUdt; dUfdt];

% define equation terms
u_iprior = U_with_boundaries(1:n);
u_i = U_with_boundaries(2:n+1);
u_inext = U_with_boundaries(3:n+2);

dudt_iprior = dUdt_with_boundaries(1:n);
dudt_i = dUdt_with_boundaries(2:n+1);
dudt_inext = dUdt_with_boundaries(3:n+2);

M = m_i;
K = Tf/dx;
B = c/dx;

% equation
displacement_solution = K*(u_iprior - 2*u_i + u_inext);
damping_solution = B*(dudt_iprior - 2*dudt_i + dudt_inext);
d2Udt2 = (displacement_solution + damping_solution)/M;


%assemble state derivative
V_out = [dUdt;d2Udt2]; %dVdt

end

