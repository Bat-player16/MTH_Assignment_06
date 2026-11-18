function [u] = Uf_function(amplitude_Uf,omega_Uf,t_in)
u=amplitude_Uf*cos(omega_Uf*t_in);