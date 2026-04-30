clc;
clear all;

%% Data preparation
% read .csv files and generate s-transfer function from measurement data
% filename = '5_x-axis_500mV_bode.csv';
filename = '5_y-axis_500mV_bode_02.csv';
[sys,frq,mag,ph,phu] = bode_waveforms(filename,1,3,4);

resp = 10.^(mag./20).*exp(1j.*ph*pi/180);
sys_meas = frd(resp,frq,'FrequencyUnit','Hz'); % create system

%% Control design
% PI Control - fill it out yourself!

alpha = 3;
wc = 2000;
w = squeeze(frq) *2 * pi;

[~, idx] = min(abs(w-wc));


gain = 10^(mag(idx) / 20)

Kp = 1/(alpha*gain)
Ki = wc/(alpha^2)
Kd = alpha/wc
Tf = 1/(alpha*wc)

syms s
C_P = Kp*(1 + Ki/s + Kd*s/(1+s*Tf));
[num, den] = numden(C_P);
num = sym2poly(num);
den = sym2poly(den);

R = tf(num, den)
Rz = c2d(R,4e-5,'zoh')
% R = pidtune(sys_meas, 'PID', 2000)

% Example: Integrator
% s = tf('s');
% R = 1/s;

%% Plotting

% figure();

% Example: Integrator continued
L = sys_meas * R;

figure();
bode(R, sys_meas, L), grid, legend

figure();
margin(L)

% bodeplot(sys_meas);
legend;
% hold on;
grid on;
% bodeplot(L);

%% Functions

function [sys,frq,mag,ph,phu] = bode_waveforms(filename,fpos,magpos,phasepos)
    T = readtable(filename);
    resp = table2array(T);
    frq = resp(:,fpos);
    mag = resp(:,magpos);
    ph = resp(:,phasepos);
    % unwrap phase
    phu = unwrap(ph*pi/180,3.5)*180/pi; % only unwrap phase if jump greater than ~324°
    resp = 10.^(mag./20).*exp(1j.*ph*pi/180);
    sys = frd(resp,frq,'FrequencyUnit','Hz'); % create system
end

