clc;
clear;
num_masses = 2;
total_mass = 10;
tension_force = 5;
string_length = 1;
damping_coeff = .02;
dx = string_length/(num_masses+1);
amplitude_Uf = 5;
omega_Uf = 2*pi;
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
tspan = [0,40];%your code here

tlist = linspace(tspan(1),tspan(end),4001);

step=tlist(end)-tlist(end-1);

my_rate_func = @(t_in,V_in) string_rate_func01(t_in,V_in,step,string_params);
%initial conditions
U0 = 0;
dUdt0 = 0;
V0 = [U0;dUdt0];
%run the integration
[~,Vlist] = ode45(my_rate_func,tlist,V0);
%your code to generate an animation of the system
Vlist
figure();
plot(tlist,Vlist(:,1))