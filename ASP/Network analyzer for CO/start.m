%===============================================================
%
% Program to use an Agilent Oscilloscope as a newtwork analyzer.
% "BodePlotLockin.m" file should be in the same directory.
% This program is for "CO" exercise.
%                                           March 11, 2014
%===============================================================

vinfo = instrhwinfo('visa','agilent');
vinfo.ObjectConstructorName

input.instrument = 'USB0::0x0957::0x179B::my53401511::0::INSTR';
input.Vout_op = 2;  % Output voltage [Vop]
input.data_points = 100; % Number of measurement points
input.wait_cycles = 2;  % Cycles to wait before measurement
input.start_freq = 1.5;   % 10^n
input.end_freq = 3;     % 10^n

bodeData = BodePlotLockin(input);

figure;
subplot(2,1,1);
semilogx(bodeData.frequency, 20*log10(bodeData.amplitude), '-sb', 'linewidth', 2);
ylabel('Amplitude [dB]');
grid on;
subplot(2,1,2);
semilogx(bodeData.frequency, bodeData.phase, '-sb', 'linewidth', 2);
ylabel('Phase [deg]');
xlabel('Frequency [Hz]');
grid on;