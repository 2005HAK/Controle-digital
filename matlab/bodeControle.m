clear; close all; clc;

% --- 1. Definição do Sistema ---
s = tf("s");
G_s = (0.0526)/(s^2 + 0.8842*s);
Kp = 3.72;

% --- 2. Malha Aberta (L) ---
% A análise de estabilidade (Margens) é feita na MALHA ABERTA!
L = Kp * G_s;

% --- 3. Malha Fechada (H) ---
% A análise de velocidade (Largura de Banda) é feita na MALHA FECHADA!
H = feedback(L, 1);

% --- 4. Plotagem e Cálculo das Margens ---
figure;
%bode(L);
% A função margin plota o Bode e já marca as margens visualmente
margin(L); 
grid on;
title(['Diagrama de Bode de Malha Aberta (Kp = ' num2str(Kp) ')']);

% Extraindo os valores numéricos
[Gm, Pm, Wcg, Wcp] = margin(L);
margin_ganho_db = 20*log10(Gm);

% --- 5. Plotagem da Malha Fechada e Largura de Banda ---
figure;
bode(H);
grid on;
title('Diagrama de Bode de Malha Fechada');

% Calculando a largura de banda (frequência onde o ganho cai -3dB)
bw = bandwidth(H);

% --- 6. Exibindo Resultados no Console ---
disp('--- Análise de Resposta em Frequência ---');
disp(['Margem de Ganho (MG): ' num2str(margin_ganho_db) ' dB']);
disp(['Margem de Fase (MF):  ' num2str(Pm) ' graus']);
disp(['Frequência de Cruzamento de Ganho: ' num2str(Wcp) ' rad/s']);
disp(['Largura de Banda (Malha Fechada): ' num2str(bw) ' rad/s']);