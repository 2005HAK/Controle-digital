clear; close all; clc;

% --- 1. Definição do Sistema ---
s = tf("s");
% Parâmetros (usando os valores arredondados do seu trabalho)
G_s = (0.0526)/(s^2 + 0.8842*s);

% --- 2. Definição do Limite ---
% Ts <= 10s  -->  4/sigma <= 10  --> sigma >= 0.4
% No plano complexo: Re(s) <= -0.4
limite_sigma = -0.4;

% --- 3. Plotagem do Lugar das Raízes ---
figure;
rlocus(G_s);
hold on;
axis equal; % Garante proporção correta
grid on;

% --- 4. Desenhando a "Região de Interesse" (Sombreado) ---

% Primeiro, pegamos os limites atuais do gráfico para saber o tamanho da área
% Isso garante que o sombreado cubra todo o fundo visível
limites_y = ylim; 
limites_x = xlim; 

% Definimos os 4 vértices do retângulo que representa a região "Boa"
% (Do extremo esquerdo do gráfico até a linha -0.4)
x_vertices = [limites_x(1), limite_sigma, limite_sigma, limites_x(1)];
y_vertices = [limites_y(1), limites_y(1), limites_y(2), limites_y(2)];

% Cria o retângulo verde (g = green)
% FaceAlpha define a transparência (0.1 é bem clarinho, 1 é sólido)
area_ts = patch(x_vertices, y_vertices, 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% --- 5. Desenhando a Linha de Fronteira ---
line_ts = plot([limite_sigma, limite_sigma], limites_y, 'r--', 'LineWidth', 2);

% --- 6. Acabamento ---
title('Lugar das Raízes com Região de Desempenho (Ts \leq 10s)');
xlabel('Eixo Real (\sigma)');
ylabel('Eixo Imaginário (j\omega)');

% Legenda para explicar o gráfico
legend([area_ts, line_ts], ...
       'Região de Desempenho Aceitável (Ts \leq 10s)', ...
       'Limite Re(s) = -0.4');

hold off;