function G = sym2tf(f)
    [num, den] = numden(f);
    num = sym2poly(num);
    den = sym2poly(den);
    G = tf(num, den);
end

ki = 1;
j = 1;
c = 0.1;
kt = -1;
kf = 2;
delay = 0.01;

Gxx = tf(ki, [j, c, kt+kf], 'InputDelay', delay)

% bode(Gxx), grid, legend


% Get Bode data 
[mag, phase, w] = bode(Gxx);
phase = squeeze(phase);
w = squeeze(w);
mag = squeeze(mag);


alpha = 3;
wc = 12;

[~, idx] = min(abs(w - wc));

gain = mag(idx);

Kp = 1/(alpha*gain)
Ki = wc/(alpha^2)
Kd = alpha/wc
Tf = 1/(alpha*wc)

syms s
C_pid = Kp*(1 + Ki/s + Kd*s/(1+s*Tf));

C_pid = sym2tf(C_pid);

open_loop = Gxx*C_pid;

bode(Gxx, C_pid, open_loop)
grid on;
legend('G_xx', 'C_P', 'G_xx*C_P');
figure
margin(open_loop)