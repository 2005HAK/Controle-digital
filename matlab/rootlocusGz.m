% Limpeza do ambiente
clear; close all; clc;

% Tempo de amostragem definido no projeto
Ts = 0.05; 

% Declaracao da variavel complexa z no dominio discreto
z = tf('z', Ts);

% Montagem da Funcao de Transferencia Discreta G(z)
% Utilizando as equacoes literais para manter a precisao das casas decimais
numerador = 0.0526 * (0.00101*z + 0.0009);
denominador = (0.8842^2) * (z - 1) * (z - exp(-0.04421));

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