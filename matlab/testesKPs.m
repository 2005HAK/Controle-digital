clear; close all; clc;

% --- 1. Definição da Planta ---
s = tf("s");
% Seus parâmetros (arredondados)
G_s = (0.0526)/(s^2 + 0.8842*s);

% --- 2. Definição dos Ganhos para Teste ---
% Vamos testar 3 cenários para ver o comportamento
% Kp_baixo: Resposta lenta, superamortecida
% Kp_medio: Perto do limite do seu PSS (calculado "de olho" no LGR)
% Kp_alto:  Resposta rápida, mas com muito sobressinal (oscilatória)
Ganhos_Kp = [3.71, 5.49, 7.26]; 

% --- 3. Simulação ---
figure;
hold on;

for Kp = Ganhos_Kp
    % Cria a Malha Aberta (L)
    L = Kp * G_s;
    
    % Cria a Malha Fechada (H) = L / (1+L)
    H = feedback(L, 1);
    
    % Simula o degrau unitário (Comando: "Desça 1 metro")
    % Se quiser descer 4 metros, bastaria multiplicar a resposta por 4.
    step(H); 
end

% --- 4. Formatação do Gráfico ---
grid on;
title('Resposta ao Degrau de Profundidade (Malha Fechada)');
xlabel('Tempo (s)');
ylabel('Profundidade \Delta z (m)');

% Cria a legenda automaticamente baseada nos valores de Kp
legend_str = cell(length(Ganhos_Kp), 1);
for i = 1:length(Ganhos_Kp)
    legend_str{i} = ['Kp = ' num2str(Ganhos_Kp(i))];
end
legend(legend_str);

hold off;