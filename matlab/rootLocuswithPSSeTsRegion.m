clear; close all; clc;

% Definição do Sistema
s = tf("s");

% Parametros da planta
G_s = (0.0526)/(s^2 + 0.8842*s);

% Definição dos Requisitos
% Requisito de Tempo
limite_sigma = -0.4;

% Requisito de PSS
zeta_min = 0.6901;
angulo_rad = acos(zeta_min);

% Plotagem do Lugar das Raízes
figure;
rlocus(G_s);
hold on; axis equal; grid on;

% Pegar os limites do grafico para desenhar as regioes ate a borda
limites_x = xlim;
limites_y = ylim;
tamanho_x = abs(limites_x(1));

% Desenhando a Regiao de Ts (Retangulo Verde)
x_ts = [limites_x(1), limite_sigma, limite_sigma, limites_x(1)];
y_ts = [limites_y(1), limites_y(1), limites_y(2), limites_y(2)];
patch(x_ts, y_ts, 'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% Desenhando a Região de PSS (Cone Azul)
altura_y = tamanho_x * tan(angulo_rad);

% Definindo o triangulo (Cone)
x_zeta = [0, -tamanho_x, -tamanho_x];
y_zeta_sup = [0, altura_y, -altura_y];

% Desenha o cone azul ('b' = blue)
patch(x_zeta, y_zeta_sup, 'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');

% Linhas de Fronteira para destaque
% Linha vertical do Ts
plot([limite_sigma, limite_sigma], limites_y, 'r--', 'LineWidth', 1.5);

% Linhas diagonais do Zeta
% Reta superior
plot([0, -tamanho_x], [0, altura_y], 'k--', 'LineWidth', 1.5); 
% Reta inferior
plot([0, -tamanho_x], [0, -altura_y], 'k--', 'LineWidth', 1.5);

title('Lugar das Raízes: Região de Operação (Ts \leq 10s e PSS \leq 5%)');
xlabel('Eixo Real (\sigma)');
ylabel('Eixo Imaginário (j\omega)');
legend('Lugar das Raízes', 'Região Ts (Verde)', 'Região Zeta (Azul)');

hold off;