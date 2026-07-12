clear; close all; clc;

% Tempo de amostragem
Ts = 0.05; 

% Declaracao da variavel complexa z no dominio discreto
z = tf('z', Ts);

% Montagem da Funcao de Transferencia Discreta G(z)
numerador = 0.0526 * (0.00101*z + 0.0009);
denominador = (0.8842^2) * (z - 1) * (z - exp(-0.04421));

Gz = numerador / denominador;

disp('Funcao de Transferencia Discreta G(z):');
Gz

% Plotagem do Lugar das Raizes
figure; 
rlocus(Gz); 
hold on; zgrid; axis equal; 

title('Lugar das Raizes da Planta Discreta G(z)');
xlabel('Eixo Real');
ylabel('Eixo Imaginario');