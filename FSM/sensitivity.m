clc;
clear all;

%% Data preparation
% read .csv files and generate s-transfer function from measurement data
filename_G = '5_x-axis_500mV_bode.csv';
filename_CG = '5_y-axis_500mV_bode_02.csv';


[sys_G,frq,mag,ph,phu] = bode_waveforms(filename_G,1,3,4);

[sys_CG,frq,mag,ph,phu] = bode_waveforms(filename_CG,1,3,4);







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
