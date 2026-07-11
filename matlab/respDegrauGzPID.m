% Limpeza do ambiente
clear; close all; clc;

% =====================================================
% 1. PARAMETROS DE ENTRADA
% =====================================================
Ts = 0.05;       % Tempo de amostragem em segundos

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

K_d=130.0000;
K_p=169.5406;
K_i=48.2725;

z = tf('z', Ts);

C_z = K_p + ((K_i*Ts)/2)*((z-1)/(z+1)) + (K_d/Ts)*((z-1)/z);
L_z = C_z * G_z;

% Funcao de transferencia de Malha Fechada: H(z) = L(z) / (1 + L(z))
% Assumindo realimentacao unitaria (sensor perfeito)
H_z = feedback(L_z, 1);

disp('--------------------------------------------------');
disp(' MALHA FECHADA DISCRETA H(z) ');
disp('--------------------------------------------------');
H_z

% =====================================================
% 5. PLOTAGEM DA RESPOSTA AO DEGRAU
% =====================================================
figure;
step(H_z); 
grid on;

% Formatacao estetica do grafico para o relatorio
title(['Resposta ao Degrau Discreta | T_s = ', num2str(Ts), ' s']);
xlabel('Tempo (s)');
ylabel('Profundidade \Delta z (m)');