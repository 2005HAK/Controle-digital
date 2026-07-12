clear; close all; clc;

s = tf("s");
G_s = (0.0526)/(s^2 + 0.8842*s);

rlocus(G_s);

hold on; axis equal;

% Título e legendas para o gráfico
title('Lugar das Raízes (Root Locus)');
xlabel('Eixo Real');
ylabel('Eixo Imaginário');