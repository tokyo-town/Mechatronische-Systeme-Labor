U_0 = 10;
R = 1;
A = 1;
K = 1;
phi_c = 0;
phi_0 = 1;

w = 20.4;

syms t
U_sens = U_0 * cos(w * t + phi_0);
U_act = A * K * cos(w * t + phi_c) / R;

U_out = U_sens * U_act;

T = 2 * pi / w;
U_lp = int(U_out, 0, T) / T;

figure();
hold on;

rng = [0 0.5];
fplot(U_sens, rng);
fplot(U_act, rng);
fplot(U_out, rng);
fplot(U_lp, rng);

grid();
legend(["U_{sens}" "U_{act}" "U_{out}" "U_{lp}"]);