% Limpeza do ambiente
clear; close all; clc;

% Tempo de amostragem definido no projeto
Ts = 0.1; 

% Declaracao da variavel complexa z no dominio discreto
z = tf('z', Ts);

% Montagem da Funcao de Transferencia Discreta G(z)
% Utilizando as equacoes literais para manter a precisao das casas decimais
numerador = 0.0526 * (0.02273*z + 0.02111);
denominador = (2.2105^2) * (z - 1) * (z - exp(-0.22105));

% Planta Discreta final
Gz = numerador / denominador;

% Exibe a funcao de transferencia no console para conferencia
disp('Funcao de Transferencia Discreta G(z):');
Gz

% Plotagem do Lugar das Raizes (Root Locus)
figure;
rlocus(Gz);
hold on;

% Adiciona o circulo unitario e a grade de amortecimento continuo (zgrid)
zgrid;

% Trava os eixos na mesma proporcao para o circulo nao ficar com formato oval
axis equal; 

% Formatacao estetica do grafico para exportacao para o relatorio
title('Lugar das Raizes da Planta Discreta G(z)');
xlabel('Eixo Real');
ylabel('Eixo Imaginario');