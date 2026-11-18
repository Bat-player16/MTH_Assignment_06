function [du] = dUfdt_function(amplitude_Uf, omega_Uf, t_in)
du=-omega_Uf*amplitude_Uf*sin(omega_Uf*t_in);
