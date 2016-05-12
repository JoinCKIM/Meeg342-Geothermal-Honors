% Clear everything
close all
clear


Tin = 23; % degree c
Tinf = 12; % degree c
%d = 0.0381; % meters (1.5 inch)
d = 0.0254; % meters (1 inch)
t = 0.0068834; % meters (thickness for 1.5 inch)
L = 30; % meters
N = [0:0.1:4.5];

vel = 0.5; % m/s
Q_flow = vel.*1/4.*pi.*d^2; % m^3/s
count = 1;
Touts = [];
Engs = [];
Toutp = [];
Engp = [];

% Loop through
for n = N
    [T,Q] = calc_outlet_parallel(Q_flow, Tin, Tinf, d, t, L, n);
    Toutp(count) = T;
    Engp(count) = Q;
    count = count + 1;
end

% Plot
figure(1)
plot(N,Toutp, '-rs')
xlabel('Number of Pipes (N)')
s = sprintf('Outlet Tempeture (%cc)', char(176));
ylabel(s)

figure(2)
plot(N,Engp, '-rs')
xlabel('Number of Pipes (N)')
ylabel('Total Heat Transfer (W)')

