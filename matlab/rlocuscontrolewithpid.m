clear; close all; clc;

s = tf("s");

K_p = 328.4945;
K_i =275.9807;
K_d = 184.9145;

C_s = (K_d * s^2 + K_p * s + K_i)/(s);

G_s = (0.0526)/(s^2 + 0.8842*s);

rlocus(C_s * G_s);

% Adiciona o círculo unitário como referência de estabilidade
hold on;
%zgrid;                                                                                  % Função do MATLAB que desenha o círculo unitário e linhas de amortecimento
axis equal;                                                                             % Garante que o círculo pareça um círculo

% Título e legendas para o gráfico
title('Lugar das Raízes (Root Locus)');
xlabel('Eixo Real');
ylabel('Eixo Imaginário');