clear; close all; clc;

% Tempo de amostragem
Ts = 0.05;

% Definicao da planta continua
s = tf('s');
G_s = 0.0526 / (s^2 + 0.8842*s);

disp('Planta continua G(s): ');
G_s

% Discretiza a planta usando ZOH
G_z = c2d(G_s, Ts, 'zoh');

disp('Planta discretizada G(z): ');
G_z

z = tf('z', Ts);

C_z = (7782.1012*(z - exp(-0.04421)))/(z + 0.4712);
L_z = C_z * G_z;

% Funcao de transferencia de Malha Fechada: H(z) = L(z) / (1 + L(z))
H_z = feedback(L_z, 1);

disp('Malha fechada H(z): ');
H_z

% Resposta ao degrau
figure; step(H_z); grid on;

title(['Resposta ao Degrau Discreta | T_s = ', num2str(Ts), ' s']);
xlabel('Tempo (s)');
ylabel('Profundidade \Delta z (m)');