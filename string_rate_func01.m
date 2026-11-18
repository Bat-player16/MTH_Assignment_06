function [V_out] = string_rate_func01(t_in,V_in,step,string_params)
%STRING_RATE_FUNC01 Summary of this function goes here
%   Detailed explanation goes here
Tf=string_params.Tf;
m=string_params.M;
Uf_func=string_params.Uf_func;
dUfdt_func=string_params.dUfdt_func;
c=string_params.c;
dx=string_params.dx;
if t_in==0
    m_term=(Tf/m)*((0-2*Uf_func(t_in)+Uf_func(t_in+step))/dx);
d_term=(c/m)*((0-2*dUfdt_func(t_in)+dUfdt_func(t_in+step))/dx);
else
m_term=(Tf/m)*((Uf_func(t_in-step)-2*Uf_func(t_in)+Uf_func(t_in+step))/dx);
d_term=(c/m)*((dUfdt_func(t_in-step)-2*dUfdt_func(t_in)+dUfdt_func(t_in+step))/dx);
end
d2udt2=m_term+d_term;
V_out=[0;0];
V_out(1,:)=V_in(2,:);
V_out(2,:)=d2udt2;
end

