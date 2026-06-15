% Limpeza do ambiente
clear; close all; clc;

% =====================================================
% 1. PARAMETROS DE ENTRADA
% =====================================================
Ts = 0.015;       % Tempo de amostragem em segundos
Kp = 3.72;     % Ganho Proporcional projetado

% =====================================================
% 2. DEFINICAO DA PLANTA CONTINUA G(s)
% =====================================================
s = tf('s');
G_s = 0.0526 / (s^2 + 0.8842*s);

disp('--------------------------------------------------');
disp(' PLANTA CONTINUA ORIGINAL G(s) ');
disp('--------------------------------------------------');
G_s

% =====================================================
% 3. DISCRETIZACAO DA PLANTA G(z)
% =====================================================
% Discretiza a planta usando Segurador de Ordem Zero (ZOH)
G_z = c2d(G_s, Ts, 'zoh');

disp('--------------------------------------------------');
disp([' PLANTA DISCRETA G(z) COM Ts = ', num2str(Ts), 's ']);
disp('--------------------------------------------------');
G_z

% =====================================================
% 4. FECHAMENTO DA MALHA DIGITAL
% =====================================================

K_p = 19.835708;
K_i = 5.648112;
K_d = 15.2091;

C_s = (K_d * s^2 + K_p * s + K_i)/(s);

% Funcao de transferencia de Malha Aberta: L(z) = C(z) * G(z)
C_z = c2d(C_s, Ts, 'tustin');   % Tustin é adequado para controladores PID
L_z = C_z * G_z;

% Funcao de transferencia de Malha Fechada: H(z) = L(z) / (1 + L(z))
% Assumindo realimentacao unitaria (sensor perfeito)
H_z = feedback(L_z, 1);

disp('--------------------------------------------------');
disp([' MALHA FECHADA DISCRETA H(z) COM Kp = ', num2str(Kp)]);
disp('--------------------------------------------------');
H_z

% =====================================================
% 5. PLOTAGEM DA RESPOSTA AO DEGRAU
% =====================================================
figure;
step(H_z); 
grid on;

% Formatacao estetica do grafico para o relatorio
title(['Resposta ao Degrau Discreta | K_p = ', num2str(Kp), ' | T_s = ', num2str(Ts), ' s']);
xlabel('Tempo (s)');
ylabel('Profundidade \Delta z (m)');