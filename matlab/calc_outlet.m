function [Tout,Q,R_water,R_pipe,R_soil] = calc_outlet(Q_flow, Tin, Tinf, d, t, L, N)

e = 0.0015e-3; % todo use the passed value

mu = 1.002e-3; %kg*s/m^2
rho = 998; % density kg/m^3
cp = 4200; %J/kgK
k_water = 0.58; %conduction of water (W/mK)
k_pipe = 0.461; %conduction of pipe (W/mK)
k_soil = 1.25; % conduction for 50% wetted sandy soil (W/mk)
r_soil = 0.3048; % Assume that 1ft away the soil becomes constant temp (m)

Pr = (cp*mu)/k_water; % Prandtl number
ed = e/d;

% Find reylonds
Red = (4*Q_flow*rho)/(N*pi*d*mu);
% Calculate friction factor
f = moody(ed,Red);
% Nusslet number
if Red < 3000
    Nud = 3.66;
else
    Nud = (f/8*(Red - 1000)*Pr)/(1+12.7*(f/8)^(1/2)*(Pr^(2/3)-1));
end
% Calculate our convection
h = Nud*k_water/d;
% Surface area
As = pi*d*L;
Ac = 1/4*pi*d^2;
% Calculate total resistance
R_water = 1/(As*h);
R_pipe = log(((d+2*t)/2)/(d/2))/(2*pi*L*k_pipe);
R_soil = log(r_soil/((d+2*t)/2))/(2*pi*L*k_soil);
Rtot = R_water + R_pipe + R_soil;
% Calculate our outlet temp
Tout = -(Tinf - Tin)*exp(-1/(Q_flow*rho*cp*Rtot)) + Tinf;
% Calc total energy transfered
Q = Q_flow*rho*cp*(Tout - Tin);

% Debug
fprintf('Parallel => Q_flow = %1.6f - Tout = %3.4f  Q = %3.4f - Red = %e  Nud = %3.3f  As = %3.3f  h = %e  f = %1.5f\n',Q_flow,Tout,Q,Red,Nud,As,h,f)

end

