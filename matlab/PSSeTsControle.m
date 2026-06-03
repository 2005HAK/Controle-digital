clear; close all; clc;

% --- 1. Definição do Sistema ---
s = tf("s");
% Parâmetros da planta do AUV
G_s = (0.0526)/(s^2 + 2.2105*s);

% --- 2. Definição dos Requisitos ---
% Requisito de Tempo: Ts <= 10s -> Re(s) <= -0.4
limite_sigma = -0.4;

% Requisito de PSS: Zeta >= 0.6901 -> Angulo <= 46.36 graus
zeta_min = 0.6901;
angulo_rad = acos(zeta_min); % Ângulo em radianos a partir do eixo real negativo

% --- 3. Plotagem do Lugar das Raízes ---
figure;
rlocus(G_s);
hold on;
axis equal; % CRUCIAL: Garante que os ângulos visuais sejam verdadeiros
grid on;

% Pegar os limites do gráfico para desenhar as regiões até a borda
limites_x = xlim;
limites_y = ylim;
tamanho_x = abs(limites_x(1)); % Distância até a esquerda

% --- 4. Desenhando a Região de Ts (Retângulo Verde) ---
% Já fizemos isso: tudo à esquerda de -0.4
x_ts = [limites_x(1), limite_sigma, limite_sigma, limites_x(1)];
y_ts = [limites_y(1), limites_y(1), limites_y(2), limites_y(2)];
patch(x_ts, y_ts, 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% --- 5. Desenhando a Região de PSS (Cone Azul) ---
% O cone é formado por duas retas saindo da origem com ângulo +/- theta
% Calculamos a altura Y correspondente ao limite esquerdo X
altura_y = tamanho_x * tan(angulo_rad);

% Definimos o triângulo (Cone)
x_zeta = [0, -tamanho_x, -tamanho_x];
y_zeta_sup = [0, altura_y, -altura_y]; % Vértice, Canto Sup Esq, Canto Inf Esq

% Desenha o cone azul ('b' = blue)
patch(x_zeta, y_zeta_sup, 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% --- 6. Linhas de Fronteira para destaque ---
% Linha vertical do Ts
plot([limite_sigma, limite_sigma], limites_y, 'r--', 'LineWidth', 1.5);

% Linhas diagonais do Zeta
% Reta superior
plot([0, -tamanho_x], [0, altura_y], 'k--', 'LineWidth', 1.5); 
% Reta inferior
plot([0, -tamanho_x], [0, -altura_y], 'k--', 'LineWidth', 1.5);

% --- 7. Acabamento ---
title('Lugar das Raízes: Região de Operação (Ts \leq 10s e PSS \leq 5%)');
xlabel('Eixo Real (\sigma)');
ylabel('Eixo Imaginário (j\omega)');
legend('Lugar das Raízes', 'Região Ts (Verde)', 'Região Zeta (Azul)');

hold off;