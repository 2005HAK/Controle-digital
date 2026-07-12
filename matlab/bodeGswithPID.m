clear; close all; clc;

% Definição do Sistema
s = tf("s");
G_s = (0.0526)/(s^2 + 0.8842*s);

K_d=130.0000;
K_p=169.5406;
K_i=48.2725;

C_s = (K_d * s^2 + K_p * s + K_i)/(s);

% Malha Aberta (L)
L = C_s * G_s;

% Malha Fechada (H)
H = feedback(L, 1);

% Plotagem e Calculo das Margens
figure;
margin(L); 
grid on;
title(['Diagrama de Bode de Malha Aberta (Cs)']);

% Extraindo os valores numéricos
[Gm, Pm, Wcg, Wcp] = margin(L);
margin_ganho_db = 20*log10(Gm);

% Plotagem da Malha Fechada e Largura de Banda
figure;
bode(H);
grid on;
title('Diagrama de Bode de Malha Fechada');

% Calculando a largura de banda
bw = bandwidth(H);

% Exibe resultados
disp('--- Análise de Resposta em Frequência ---');
disp(['Margem de Ganho (MG): ' num2str(margin_ganho_db) ' dB']);
disp(['Margem de Fase (MF):  ' num2str(Pm) ' graus']);
disp(['Frequência de Cruzamento de Ganho: ' num2str(Wcp) ' rad/s']);
disp(['Largura de Banda (Malha Fechada): ' num2str(bw) ' rad/s']);