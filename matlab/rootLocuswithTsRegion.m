clear; close all; clc;

% Definição do Sistema
s = tf("s");
G_s = (0.0526)/(s^2 + 0.8842*s);

% Definição do Limite
limite_sigma = -0.4;

% Plotagem do Lugar das Raízes
figure;
rlocus(G_s);
hold on; axis equal; grid on;

% Desenhando a "Região de Interesse" (Sombreado)
limites_y = ylim; 
limites_x = xlim; 

x_vertices = [limites_x(1), limite_sigma, limite_sigma, limites_x(1)];
y_vertices = [limites_y(1), limites_y(1), limites_y(2), limites_y(2)];

% Cria o retangulo verde (g = green)
area_ts = patch(x_vertices, y_vertices, 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% Desenhando a Linha de Fronteira
line_ts = plot([limite_sigma, limite_sigma], limites_y, 'r--', 'LineWidth', 2);

title('Lugar das Raízes com Região de Desempenho (Ts \leq 10s)');
xlabel('Eixo Real (\sigma)');
ylabel('Eixo Imaginário (j\omega)');

% Legenda
legend([area_ts, line_ts], 'Região de Desempenho Aceitável (Ts \leq 10s)', 'Limite Re(s) = -0.4');

hold off;