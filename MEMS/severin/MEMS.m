clear all
close all


A = [-91 -307 ; 256 0];
B = [128; 0];
C = [180 55];
D = 0;

%% 
% a)

sys_ss = ss(A, B , C , D);

sys_tf = tf(sys_ss)

[z, p , k] = zpkdata(sys_tf, 'v')

% Display the zeros, poles, and gain
disp('Zeros:');
disp(z);
disp('Poles:');
disp(p);
disp('Gain:');
disp(k);

%Bode Plot
figure;
bode(sys_tf);
grid on;
title('Bode-Diagramm');

% PZ-Plot
figure;
pzplot(sys_tf);
grid on;
% axis equal;
title('Pole-Zero-Plot')

%% 
% b)

fs = 4.5e3;
fs = 4480;
N = 512;

Ts = 1/fs;
t = (0:N-1)' * Ts;      % Zeitvektor

u = ones(size(t));

[y, ~] = lsim(sys_tf,u,t);

noise_var = 2;
noise = sqrt(noise_var) * randn(size(t));  % sqrt(2) weil Varianz(^2)

y_noise = y + noise;


%noise
noise_m = [5342, 5402, 5402, 5222, 5382, 5482, 5212, 5442, 5452, 5292, 5482, 5472, 5432, 5492, 5432, 5532, 5442, 5432, 5472, 5432, 5412, 5392, 5392, 5462, 5342, 5422, 5442, 5362, 5452, 5472, 5442, 5452, 5432, 5492, 5412, 5432, 5492, 5392, 5442, 5422, 5432, 5342, 5382, 5412, 5202, 5392, 5472, 5192, 5442, 5462, 5312, 5502, 5432, 5462, 5462, 5452, 5512, 5462, 5412, 5462, 5392, 5422, 5332, 5422, 5442, 5332, 5432, 5452, 5392, 5442, 5442, 5452, 5462, 5432, 5502, 5432, 5442, 5452, 5422, 5402, 5402, 5402, 5272, 5382, 5422, 5202, 5402, 5482, 5222, 5482, 5462, 5362, 5492, 5442, 5502, 5452, 5442, 5512, 5442, 5392, 5462, 5402, 5452, 5322, 5412, 5452, 5352, 5432, 5472, 5402, 5472, 5422, 5502, 5442, 5432, 5522, 5452, 5432, 5462, 5402, 5392, 5392, 5422, 5262, 5372, 5452, 5182, 5422, 5442, 5242, 5462, 5432, 5392, 5482, 5422, 5502, 5462, 5422, 5512, 5422, 5412, 5432, 5412, 5412, 5322, 5402, 5472, 5352, 5462, 5472, 5412, 5482, 5452, 5482, 5452, 5412, 5512, 5442, 5422, 5462, 5422, 5372, 5392, 5422, 5232, 5382, 5452, 5182, 5412, 5482, 5292, 5472, 5452, 5422, 5472, 5442, 5502, 5472, 5412, 5522, 5412, 5442, 5412, 5392, 5452, 5342, 5422, 5452, 5362, 5472, 5452, 5462, 5472, 5422, 5512, 5442, 5442, 5492, 5392, 5432, 5422, 5422, 5342, 5372, 5432, 5222, 5382, 5462, 5202, 5452, 5482, 5312, 5512, 5452, 5442, 5492, 5412, 5512, 5432, 5422, 5472, 5402, 5442, 5382, 5422, 5432, 5342, 5462, 5432, 5382, 5492, 5432, 5462, 5502, 5452, 5532, 5442, 5452, 5512, 5422, 5442, 5412, 5432, 5332, 5402, 5442, 5182, 5382, 5462, 5232, 5472, 5452, 5312, 5472, 5442, 5462]
%step i
step_i = [11873, 12363, 12813, 13403, 13813, 14203, 14713, 14803, 15463, 15963, 16203, 16493, 16583, 16873, 17223, 17433, 17563, 17623, 17643, 17753, 17813, 17713, 17663, 17593, 17413, 17353, 17193, 16953, 16823, 16443, 16203, 16013, 15743, 15393, 14973, 14713, 14453, 14043, 13823, 13323, 13073, 12803, 12473, 12323, 11883, 11613, 11443, 11143, 11083, 10733, 10573, 10483, 10313, 10283, 10133, 10023, 10033, 10043, 10023, 10143, 10053, 10173, 10303, 10203, 10613, 10633, 10753, 10983, 10873, 11313, 11613, 11703, 11903, 11933, 12253, 12593, 12823, 12973, 13153, 13293, 13543, 13783, 13973, 14123, 14293, 14373, 14533, 14673, 14763, 14943, 14893, 14963, 15063, 15103, 15143, 15133, 15043, 15013, 15063, 14913, 14973, 14803, 14753, 14673, 14353, 14533, 14343, 14133, 14063, 13653, 13843, 13713, 13523, 13353, 12943, 13113, 13033, 12823, 12693, 12303, 12453, 12443, 12303, 12193, 11903, 11933, 11993, 11913, 11893, 11713, 11653, 11813, 11843, 11753, 11813, 11743, 11803, 11953, 11943, 11963, 12083, 12033, 12193, 12243, 12353, 12503, 12483, 12563, 12723, 12793, 12923, 12983, 12973, 13133, 13263, 13183, 13443, 13443, 13513, 13603, 13403, 13713, 13823, 13783, 13843, 13583, 13883, 13973, 13963, 13943, 13703, 13853, 14003, 13963, 13893, 13753, 13693, 13793, 13803, 13743, 13693, 13573, 13543, 13553, 13493, 13393, 13353, 13223, 13253, 13203, 13123, 13103, 12953, 12923, 12923, 12833, 12893, 12713, 12663, 12693, 12683, 12693, 12663, 12543, 12583, 12563, 12493, 12633, 12543, 12533, 12573, 12373, 12673, 12623, 12613, 12653, 12393, 12683, 12823, 12753, 12783, 12563, 12773, 12953, 12953, 12933, 12873, 12953, 13093, 13193, 13183, 13193, 13163, 13233, 13363, 13333, 13333, 13393, 13333, 13403, 13473, 13443, 13543, 13403, 13443, 13463, 13453, 13553, 13453, 13393, 13473, 13443, 13433, 13443, 13353, 13313, 13343, 13193, 13353, 13213, 13183, 13203, 12953, 13193, 13153, 13083, 13073, 12763, 13013, 13073, 12983, 12923, 12723, 12823, 13003, 12943, 12893, 12703, 12773, 12853, 12883, 12833, 12803, 12743, 12813, 12923, 12913, 12873, 12883, 12803, 12943, 12923, 12913, 12993, 12883, 12943, 13013, 12993, 13143, 13003, 12993, 13103, 13103, 13123, 13163, 13073, 13173, 13193, 13103, 13253, 13153, 13143, 13253, 12983, 13263, 13243, 13203, 13273, 12963, 13213, 13293, 13223, 13233, 13033, 13143, 13313, 13263, 13203, 13123, 13073, 13193, 13233, 13173, 13133, 13073, 13123, 13203, 13153, 13103, 13073, 13013, 13113, 13133, 13053, 13143, 12993, 13023, 13063, 13043, 13113, 13053, 12973, 13003, 13003, 13043, 13053, 12973, 12973, 13033, 12873, 13093, 12993, 12973, 13003, 12793, 13073, 13053, 13003, 13013, 12703, 13013, 13123, 13073, 13043, 12793, 12993, 13153, 13133, 13063, 12943, 12953, 13123, 13143, 13103, 13093, 13043, 13103, 13183, 13163, 13123, 13163, 13043, 13183, 13163, 13163, 13253, 13133, 13143, 13183, 13143, 13243, 13133, 13103, 13153, 13183, 13153, 13193, 13073, 13083, 13123, 13003, 13213, 13143, 13063, 13133, 12863, 13123, 13113, 13063, 13073, 12783, 13053, 13143, 13083, 13073, 12833, 13003, 13103, 13093, 13023, 12963, 12923, 13063, 13103, 13083, 13073, 13013, 13013, 13103, 13063, 13033, 13083, 13003, 13093, 13113, 13073, 13163, 13023, 13043, 13133, 13123, 13183, 13103, 13023, 13123, 13133, 13113, 13163, 13063, 13093, 13163, 12973, 13193, 13113, 13083, 13123, 12873, 13163, 13143, 13083, 13103, 12833, 13123, 13183, 13133, 13093, 12883, 12993, 13193, 13143, 13123, 13013, 13003, 13113, 13163, 13093, 13083, 13023, 13043, 13153, 13103, 13083, 13103, 13023, 13073, 13133, 13103, 13153, 13043, 13033, 13093, 13073, 13163, 13093, 13053, 13073, 13123, 13043, 13173, 13043, 13063, 13093]
%step I
step_I = [11550, 11490, 11490, 11480, 11580, 11600, 11540, 11640, 11500, 11520, 11580, 11570, 11560, 11610, 11560, 11520, 11580, 11300, 11540, 11590, 11560, 11530, 11330, 11440, 11570, 11600, 11530, 11560, 11510, 11500, 11580, 11580, 11580, 11660, 11570, 11500, 11580, 11540, 11490, 11630, 11560, 11520, 11590, 11260, 11540, 11620, 11570, 11540, 11460, 11410, 11540, 11620, 11540, 11560, 11550, 11510, 11550, 11580, 11560, 11630, 11630, 11540, 11530, 11560, 11390, 11610, 11610, 11530, 11580, 11260, 11460, 11600, 11590, 11520, 11480, 11460, 11520, 11600, 11580, 11510, 11630, 11480, 11550, 11550, 11580, 11580, 11620, 11490, 11540, 11590, 11310, 11610, 11570, 11510, 11530, 11300, 11430, 11590, 11620, 11540, 11550, 11470, 11510, 11600, 11580, 11570, 11680, 11570, 11520, 11570, 11570, 11530, 11670, 11550, 11520, 11550, 11280, 11560, 11640, 11550, 11560, 11410, 11450, 11580, 11580, 11580, 11530, 11570, 11480, 11570, 11580, 11570, 11680, 11580, 11500, 11560, 11590, 11460, 11650, 11540, 11520, 11530, 11250, 11520, 11630, 11550, 11540, 11420, 11450, 11510, 11580, 11580, 11540, 11600, 11490, 11540, 11560, 11530, 11640, 11600, 11500, 11540, 11570, 11370, 11640, 11590, 11520, 11560, 11260, 11470, 11600, 11560, 11510, 11510, 11480, 11470, 11560, 11610, 11540, 11640, 11510, 11540, 11570, 11560, 11600, 11630, 11490, 11530, 11590, 11330, 11560, 11600, 11520, 11550, 11350, 11470, 11610, 11580, 11570, 11520, 11510, 11470, 11570, 11610, 11560, 11650, 11510, 11540, 11580, 11560, 11520, 11660, 11540, 11540, 11620, 11260, 11550, 11630, 11550, 11560, 11430, 11400, 11570, 11580, 11590, 11550, 11580, 11460, 11550, 11590, 11540, 11630, 11610, 11490, 11560, 11610, 11460, 11650, 11590, 11540, 11570, 11230, 11520, 11610, 11580, 11560, 11480, 11460, 11540, 11560, 11570, 11520, 11590, 11500, 11500, 11570, 11580, 11640, 11600, 11530, 11530, 11570, 11340, 11630, 11580, 11560, 11560, 11260, 11440, 11570, 11570, 11560, 11510, 11480, 11530, 11540, 11570, 11560, 11660, 11530, 11520, 11560, 11580, 11530, 11630, 11500, 11530, 11580, 11290, 11600, 11640, 11540, 11550, 11360, 11450, 11570, 11600, 11560, 11560, 11530, 11490, 11550, 11570, 11570, 11630, 11560, 11500, 11560, 11560, 11500, 11650, 11520, 11530, 11540, 11270, 11530, 11580, 11570, 11530, 11450, 11410, 11530, 11610, 11540, 11540, 11590, 11470, 11550, 11600, 11560, 11650, 11590, 11520, 11550, 11560, 11390, 11640, 11550, 11540, 11560, 11250, 11510, 11610, 11570, 11530, 11490, 11440, 11520, 11610, 11550, 11550, 11640, 11490, 11550, 11570, 11570, 11610, 11590, 11550, 11520, 11580, 11350, 11590, 11600, 11530, 11540, 11340, 11470, 11590, 11560, 11560, 11520, 11490, 11520, 11600, 11570, 11570, 11610, 11560, 11510, 11570, 11580, 11530, 11620, 11520, 11510, 11580, 11300, 11570, 11620, 11540, 11550, 11370, 11420, 11590, 11600, 11550, 11560, 11540, 11510, 11570, 11580, 11570, 11660, 11550, 11520, 11540, 11580, 11460, 11620, 11570, 11520, 11580, 11260, 11540, 11630, 11560, 11560, 11450, 11440, 11540, 11580, 11560, 11530, 11580, 11490, 11550, 11560, 11580, 11650, 11590, 11530, 11530, 11580, 11390, 11640, 11590, 11530, 11550, 11300, 11490, 11620, 11560, 11540, 11480, 11470, 11530, 11580, 11580, 11540, 11640, 11510, 11510, 11570, 11580, 11580, 11630, 11510, 11510, 11560, 11340, 11580, 11610, 11520, 11580, 11350, 11440, 11560, 11590, 11570, 11540, 11510, 11470, 11550, 11580, 11560, 11680, 11550, 11510, 11560, 11590, 11490, 11640, 11560, 11520, 11540, 11280, 11590, 11600, 11560, 11560, 11410, 11460, 11590, 11600, 11550, 11590, 11550, 11490, 11570, 11590, 11560, 11650, 11560, 11520, 11550, 11600, 11440, 11640, 11590, 11520, 11560]

step_use = step_i;

step_use = step_use - 10750;

y_noise = step_use';
size(y_noise)
data = iddata(y_noise, u ,Ts);  

% Systemidentifikation
sys_id = tfest(data,2,1,'Ts',0);       


[y_id, ~] = lsim(sys_id,u,t);

figure();
hold on
plot(t, y_id)
plot(t, step_use)

grid();
legend();

% Vergleich beider Systeme im Bode-Plot
figure;
bode(sys_tf, sys_id);
legend('Originalsystem', 'Identifiziertes System');
title('Bode-Vergleich: Original vs. Identifiziert');
grid on;

% Pol-Nullstellen-Diagramm
figure;
pzmap(sys_tf, sys_id);
legend('Originalsystem', 'Identifiziertes System');
title('Pol-Nullstellen-Diagramm-Vergleich: Original vs. Identifiziert');
grid on;
% axis equal;

P = tf(sys_id);
C_I = design_I_cntrl(P, 60);

figure();
margin(P * C_I)
grid();

% design_PI_cntrl(sys_id, )








% hohe Sprungamplitude besser
% kleineres Rauschen besser (Rauschvarianz) für systemidentifikation

% SNR = A^2/varianz_noise^2



% % für csv export fürs Protokoll
% % Frequenzvektor (logarithmisch, z. B. 10–10000 Hz)
% f = logspace(1, 4, 500);           % Frequenz in Hz
% w = 2*pi*f;                        % Kreisfrequenz in rad/s
% 
% % Bode-Daten berechnen
% [mag_tf, phase_tf] = bode(sys_tf, w);
% [mag_id, phase_id] = bode(sys_id, w);
% 
% % Umformen (squeeze)
% mag_tf = squeeze(mag_tf);
% phase_tf = squeeze(phase_tf);
% mag_id = squeeze(mag_id);
% phase_id = squeeze(phase_id);
% 
% % In dB umwandeln
% mag_tf_dB = 20*log10(mag_tf);
% mag_id_dB = 20*log10(mag_id);
% 
% % Tabelle erstellen
% T = table(f', mag_tf_dB, phase_tf, mag_id_dB, phase_id, ...
%     'VariableNames', {'f', 'mag_sim', 'phase_sim', 'mag_meas', 'phase_meas'});
% 
% % Als CSV speichern
% writetable(T, 'Bode_PT2_Compare.csv', 'Delimiter', ';');


% %% c) I-Regler Design
% fc_list = [100, 200, 300, 400];  % Hz
% omega_list = 2*pi*fc_list;
% 
% figure; hold on;
% colors = ['b','r','g','m'];
% 
% for i = 1:length(fc_list)
%     wc = omega_list(i);
% 
%     % Verstärkung der Strecke bei wc berechnen
%     P_wc = freqresp(sys_tf, wc);       % komplexer Wert
%     P_mag = abs(P_wc);                  % Betrag
% 
%     % kI berechnen sodass |L(jwc)| = 1
%     kI = wc / P_mag;
% 
%     % I-Regler
%     CI = tf(kI, [1 0]);
% 
%     % Loop function
%     L_I = CI * sys_tf;
% 
%     % Phasenrand
%     [~, pm] = margin(L_I);
% 
%     fprintf('fc = %d Hz: kI = %.4f, Phasenrand = %.2f°\n', fc_list(i), kI, pm);
% 
%     % Bode plotten
%     bode(L_I, colors(i));
% end
% 
% legend('fc=100Hz','fc=200Hz','fc=300Hz','fc=400Hz');
% title('Bode-Diagramm Loopfunction L = CI*P');
% grid on;
% 
% 
% 
% %% d) PI-Regler Design
% fc = 400; 
% wc = 2*pi*fc;
% PM_target = 70;
% 
% % 1. Amplitudengang und Phase der Strecke bei wc
% [mag_P, phase_P] = bode(sys_tf, wc);
% mag_P = squeeze(mag_P);
% phase_P = squeeze(phase_P);
% 
% % 2. Notwendige Reglerphase berechnen
% % PM = 180 + phase_P + phase_C
% phase_C = PM_target - 180 - phase_P;
% 
% % 3. Tn berechnen
% % phase_C = atan(wc*Tn) - 90
% Tn = tan(deg2rad(phase_C + 90)) / wc;
% 
% % 4. Kp berechnen, damit |L(jwc)| = 1
% mag_C_unit_Kp = abs(1 + 1/(1i * wc * Tn));
% Kp = 1 / (mag_P * mag_C_unit_Kp);
% 
% 
% fprintf('\n--- PI-Regler Parameter ---\n');
% fprintf('Proportionalbeiwert Kp:  %.4f\n', Kp);
% fprintf('Nachstellzeit Tn:       %.6f s\n', Tn);
% fprintf('Integraler Beiwert Ki:  %.4f (für die Form Kp + Ki/s)\n', Kp/Tn);
% 
% % Regler erstellen
% C_pi = Kp * tf([Tn 1], [Tn 0]);
% 
% % Überprüfung
% L_PI = C_pi * sys_tf;
% [gm, pm, wcp, wcg] = margin(L_PI);
% fprintf('Erreichte Phasenreserve: %.2f Grad bei %.2f Hz\n', pm, wcg/(2*pi));
% 
% figure;
% margin(L_PI);
% grid on;
% 
% [~, phase_L_PI] = bode(L_PI, wc);
% phase_L_PI = squeeze(phase_L_PI);
% fprintf('Phase von L bei 400 Hz: %.2f°\n', phase_L_PI);
% fprintf('Phasenrand manuell: %.2f°\n', 180 + phase_L_PI);
% 
% 
% % I-Regler funktioniert nicht bei 400Hz weil der I-Anteil alleine schon
% % -90° Phase macht und die Strecke bereits eine hohe Phasenverzögerung hat
% 
% 
% % I-Regler bei 400 Hz neu erstellen
% wc_400 = 2*pi*400;
% P_wc_400 = freqresp(sys_tf, wc_400);
% kI_400 = wc_400 / abs(P_wc_400);
% CI_400 = tf(kI_400, [1 0]);
% L_I_400 = CI_400 * sys_tf;
% 
% 
% % Sensitivity Function Sd = 1/(1 + L)
% Sd_I  = sys_tf / (1 + L_I_400);
% Sd_PI = sys_tf / (1 + L_PI);
% 
% % Loop Function
% figure;
% bode(L_I_400, 'b', L_PI, 'r--');
% legend('I-Regler 400Hz', 'PI-Regler');
% title('Loop Function L');
% grid on;
% 
% % Controller TF
% figure;
% bode(CI_400, 'b', C_pi, 'r--');
% legend('I-Regler 400Hz', 'PI-Regler');
% title('Controller Transfer Function C');
% grid on;
% 
% % Process Sensitivity
% figure;
% bode(Sd_I, 'b', Sd_PI, 'r--');
% legend('I-Regler 400Hz', 'PI-Regler');
% title('Process Sensitivity S_d = 1/(1+L)');
% grid on;
% 
% 
% % Sprungantwort Process Sensitivity
% figure;
% step(Sd_I, 'b', Sd_PI, 'r--');
% legend('I-Regler 400Hz', 'PI-Regler');
% title('Sprungantwort Process Sensitivity S_d');
% grid on;
% 
% 
% %% e)
% 
% % Diskretisierung mit Zero-Order Hold (ZOH)
% P_d = c2d(sys_tf, Ts, 'zoh');     % Diskretisierte Strecke
% CPI_d = c2d(C_pi, Ts, 'zoh');     % Diskretisierung des PI-Reglers (ZOH für Mikrocontroller geeignet)
% 
% disp('Diskreter PI-Regler:');
% CPI_d
% 
% 
% % Geschlossener Kreis (z. B. für Regelung auf Referenz)
% CL_d = feedback(P_d * CPI_d, 1);  % 1 ist Feedback-Zweig (unity feedback)
% 
% 
% % Schrittantwort simulieren
% figure;
% step(CL_d);
% title('Closed-loop Step Response (Discrete-Time)');
% xlabel('Zeit');
% ylabel('\Delta t_\phi [ns]');
% grid on;
% 
% % Diskrete PI-Parameter extrahieren
% [num_d, den_d] = tfdata(CPI_d, 'v');  % Zähler & Nenner als Vektoren
% 
% kP_d = num_d(1);
% kI_d = num_d(2) + num_d(1);
% 
% fprintf('\n--- Diskrete PI-Regler Parameter ---\n');
% fprintf('kP_d = %.6f\n', kP_d);
% fprintf('kI_d = %.6f\n', kI_d);

%% TIP

function CI = design_I_cntrl(P, fc)
    wc = 2*pi*fc;
    [mag_P, ~] = bode(P, wc);
    mag_P = squeeze(mag_P);

    kI = wc / mag_P;
    CI = tf(kI, [1 0]);
end

function C_PI = design_PI_cntrl(P, fc, phase_margin)
    wc = 2*pi*fc;
    
    [mag_P, phase_P] = bode(P, wc);
    mag_P  = squeeze(mag_P);
    phase_P = squeeze(phase_P);
    
    phase_C = phase_margin - 180 - phase_P;
    Tn = tan(deg2rad(phase_C + 90)) / wc;
    
    mag_C_unit_Kp = abs(1 + 1/(1i * wc * Tn));
    Kp = 1 / (mag_P * mag_C_unit_Kp);
    
    C_PI = Kp * tf([Tn 1], [Tn 0]);
end



%% f

% Für dieses System 2. Ordnung ist ein PI-Regler ausreichend. 
% Ein PID wäre nur sinnvoll wenn eine deutlich höhere Bandbreite als 400 Hz benötigt wird und das Rauschen gering genug ist.



% Kp_test = 0.101043;
% Ki_test = 0.020894;
% %Ts = 1/400;   % Beispiel: 400 Hz Abtastrate
% 
% z = tf('z', Ts);
% 
% Cz = Kp_test + Ki_test/(z - 1)