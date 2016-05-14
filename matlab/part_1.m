% Clear everything
close all
clear


Tin = 23; % degree c
Tinf = 12; % degree c
%d = 0.0381; % meters (1.5 inch)
d = 0.0254; % meters (1 inch)
t = 0.0068834; % meters (thickness for 1.5 inch)
L = 30; % meters

vel = [0:0.01:1]; % m/s
Q_flow = vel.*1/4.*pi.*d^2; % m^3/s
count = 1;
Touts = [];
Engs = [];
Toutp = [];
Engp = [];

% Loop through
for q = Q_flow
    [T,Q] = calc_outlet(q, Tin, Tinf, d, t, L, 1);
    Touts(count) = T;
    Engs(count) = Q;
    [T,Q] = calc_outlet(q, Tin, Tinf, d, t, L, 3);
    Toutp(count) = T;
    Engp(count) = Q;
    count = count + 1;
end

% Plot
figure(1)
plot(Q_flow,Touts, '-bs')
hold on
plot(Q_flow,Toutp, '-rs')
legend('Series', 'Parallel')
xlabel('Volumetric flow rate (m^3/s)')
s = sprintf('Outlet Tempeture (%cc)', char(176));
ylabel(s)

figure(2)
plot(Q_flow,Engs, '-bs')
hold on
plot(Q_flow,Engp, '-rs')
legend('Series', 'Parallel')
xlabel('Volumetric flow rate (m^3/s)')
ylabel('Total Heat Transfer (W)')

