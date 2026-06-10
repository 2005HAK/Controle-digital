% Limpeza do ambiente
clear; close all; clc;

% =====================================================
% 1. PARAMETROS DE ENTRADA
% =====================================================
% Defina aqui o tempo de amostragem escolhido
Ts = 0.1; % (10 Hz, conforme definido no relatorio)

% =====================================================
% 2. PLANTA NO DOMINIO CONTINUO G(s)
% =====================================================
% Declaracao da variavel complexa 's'
s = tf('s');

% Funcao de transferencia da Yvy (Baseada nos seus parametros fisicos)
G_s = 0.0526 / (s^2 + 2.2105*s);

disp('--------------------------------------------------');
disp(' PLANTA CONTINUA G(s) ');
disp('--------------------------------------------------');
G_s

% =====================================================
% 3. DISCRETIZACAO PARA O DOMINIO G(z)
% =====================================================
% O comando c2d converte a planta. 
% O argumento 'zoh' diz para a matematica simular o hardware real 
% (o microcontrolador segurando o sinal de tensao para os motores).
G_z = c2d(G_s, Ts, 'zoh');

disp('--------------------------------------------------');
disp([' PLANTA DISCRETA G(z) COM Ts = ', num2str(Ts), ' s ']);
disp('--------------------------------------------------');
G_z

% =====================================================
% 4. PLOTAGEM DO LUGAR DAS RAIZES (OPCIONAL)
% =====================================================
% Ja plota automaticamente para voce conferir a estabilidade
figure;
rlocus(G_z);
hold on;
zgrid;      % Desenha o circulo unitario e as linhas de amortecimento
axis equal; % Mantem a proporcao do circulo perfeita
title(['Lugar das Raizes da Planta Discreta G(z) | Ts = ', num2str(Ts), 's']);
xlabel('Eixo Real');
ylabel('Eixo Imaginario');