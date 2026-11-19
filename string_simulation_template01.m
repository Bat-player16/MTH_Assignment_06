clc;
clear;
num_masses = 6;
total_mass = 10;
tension_force = 5;
string_length = 1;
damping_coeff = .02;
dx = string_length/(num_masses+1);
amplitude_Uf = 0.05;
omega_Uf = 2*pi;

% KEY VARS
% U -> displacement of the masses, one row per mass
% Uf -> displacement of the actuator
% V -> displacement and velocity in the same column vector
%   2 columns per mass: one displacement and one velocity
%   all displacement together, then all velocity together, like u_m1, u_m2, du_m1, du_m2

%list of x points (including the two endpoints)
xlist = linspace(0,string_length,num_masses+2);

Uf_func = @(t_in) Uf_function(amplitude_Uf,omega_Uf,t_in);
dUfdt_func = @(t_in) dUfdt_function(amplitude_Uf,omega_Uf,t_in);

%generate the struct
string_params = struct();
string_params.n = num_masses;
string_params.M = total_mass;
string_params.Uf_func = Uf_func;
string_params.dUfdt_func = dUfdt_func;
string_params.Tf = tension_force;
string_params.L = string_length;
string_params.c = damping_coeff;
string_params.dx = dx;

%load string_params into rate function
my_rate_func = @(t_in,V_in) string_rate_func01(t_in,V_in,string_params);

%initial conditions
U0 = linspace(0, Uf_func(0), num_masses+2)'; % needs to be vertical
U0 = U0(2:end-1);
dUdt0 = zeros(num_masses, 1);
V0 = [U0;dUdt0];

tspan = [0, 40];
tlist = linspace(tspan(1), tspan(end), 4001);

%run intergration
[tlist, Vlist] = ode45(my_rate_func, tlist, V0);

% test plot to see the mass 1 displacement and velocity (not for
% submission)
figure();
plot(tlist,Vlist(:,1)) % plotting the displacements for mass 1
hold on;
plot(tlist, Vlist(:,num_masses+1)); %plotting the velocity for mass 1

%% mode analysis
% assuming damping is zero and no forcing
% generalized eigenvalue problem
[M_mat,K_mat] = construct_2nd_order_matrices(string_params);
[Ur_mat, lambda_mat] = eig(K_mat, M_mat);

% get the frequencies
lambda_vals = diag(lambda_mat);
omega_r = sqrt(lambda_vals);
for i = 1:num_masses %normalize so you can see the difference
    Ur_mat(:,i) = Ur_mat(:,i)/max(abs(Ur_mat(:,i)));
end


% mode to test
for mode_index = 1:6
    omega_Uf = omega_r(mode_index);
    Uf_func = @(t_in) Uf_function(amplitude_Uf,omega_Uf,t_in);
    dUfdt_func = @(t_in) dUfdt_function(amplitude_Uf,omega_Uf,t_in);
    string_params.Uf_func = Uf_func;
    string_params.dUfdt_func = dUfdt_func;
    my_rate_func = @(t_in,V_in) string_rate_func01(t_in,V_in,string_params);
    U0 = linspace(0, Uf_func(0), num_masses+2)'; % needs to be vertical
    U0 = U0(2:end-1);
    dUdt0 = zeros(num_masses, 1);
    V0 = [U0;dUdt0];
    
    tspan = [0, 40];
    tlist = linspace(tspan(1), tspan(end), 4001);
    
    %run intergration
    [tlist, Vlist] = ode45(my_rate_func, tlist, V0);

    % animation here (per mode index)

end
