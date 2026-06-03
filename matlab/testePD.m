clear; clc; close all;

s = tf("s");
G = 0.0526 / (s^2 + 2.2105*s);

% --- 2. Definição dos Requisitos ---
% Requisito de Tempo: Ts <= 10s -> Re(s) <= -0.4
limite_sigma = -0.4;

% Requisito de PSS: Zeta >= 0.6901 -> Angulo <= 46.36 graus
zeta_min = 0.6901;
angulo_rad = acos(zeta_min); % Ângulo em radianos a partir do eixo real negativo

% --- Estratégia de Projeto PD ---
% O PD adiciona um zero em s = -z_c
% Quanto mais longe da origem, menos efeito ele tem.
% Quanto mais perto, mais ele "puxa" os polos para a esquerda (mais rápido).

zero_pd = 3; % Exemplo: Vamos colocar o zero em s = -1.5
% Isso significa que a razão Kp/Kd será 1.5

% A nova "planta equivalente" para o lugar das raizes é G(s) * (s + z)
G_pd = G * (s + zero_pd);

figure;
rlocus(G_pd);
hold on;
sgrid(0.69, []); % Linha do seu PSS de 5% (zeta = 0.69)
title(['Lugar das Raízes com Zero do PD em s = -', num2str(zero_pd)]);

% Nota: O ganho "K" que você escolher no gráfico será o seu Kd.
% Depois você calcula Kp = Kd * zero_pd


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

% --- 8. Validação Temporal (Pós-Gráfico) ---
% Suponha que você clicou no gráfico e achou um Ganho (Kd) = 20 (exemplo!)
% Troque 20 pelo valor que você achou:
Kd_escolhido = 133; 
Kp_calculado = Kd_escolhido * zero_pd;

% Monta o controlador
C_final = tf([Kd_escolhido, Kp_calculado], 1); % Kd*s + Kp

% Malha Fechada
H_final = feedback(C_final * G, 1);

% Simula
figure;
step(H_final);
grid on;
title(['Resposta ao Degrau com PD (Kp=', num2str(Kp_calculado), ', Kd=', num2str(Kd_escolhido), ')']);