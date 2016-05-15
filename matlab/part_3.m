% Clear everything
close all
clear


Tin = -3; % degree c
Tinf = 12; % degree c
%d = 0.0381; % meters (1.5 inch)
d = 0.0254; % meters (1 inch)
t = 0.0068834; % meters (thickness for 1.5 inch)
L = 60; % meters

vel = [0:0.01:0.8]; % m/s
Q_flow = vel.*1/4.*pi.*d^2; % m^3/s
count = 1;
R_water = [];
R_pipe = [];
R_soil = [];

% Loop through
for q = Q_flow
    [~,~,r1,r2,r3] = calc_outlet(q, Tin, Tinf, d, t, L, 1);
    R_water(count) = r1;
    R_pipe(count) = r2;
    R_soil(count) = r3;
    count = count + 1;
end

% Plot
figure(1)
plot(Q_flow,R_water, '-bs')
hold on
plot(Q_flow,R_pipe, '-rs')
plot(Q_flow,R_soil, '-gs')
legend('R_{inner}', 'R_{pipe}', 'R_{soil}')
xlabel('Volumetric flow rate (m^3/s)')
ylabel('Thermal Resistance')


