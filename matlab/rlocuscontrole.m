clear; close all; clc;

s = tf("s");
G_s = (0.0526)/(s^2 + 2.2105*s);

rlocus(G_s);

% Adiciona o círculo unitário como referência de estabilidade
hold on;
%zgrid;                                                                                  % Função do MATLAB que desenha o círculo unitário e linhas de amortecimento
axis equal;                                                                             % Garante que o círculo pareça um círculo

% Título e legendas para o gráfico
title('Lugar das Raízes (Root Locus)');
xlabel('Eixo Real');
ylabel('Eixo Imaginário');