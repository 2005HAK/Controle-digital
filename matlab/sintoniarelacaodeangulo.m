clear; close all; clc;
s = tf('s');

% --- Planta e requisitos ---
G_s = 0.0526 / (s^2 + 0.8842*s);
sigma   = -0.4;           % fronteira de tempo de acomodação
zeta    = 0.6901;
omega_d = sigma * sqrt(1 - zeta^2) / (-zeta);  % Im do polo no vértice

s_star = sigma + 1j*omega_d;
fprintf('Polo desejado s* = %.4f + %.4fj\n', real(s_star), imag(s_star));

% --- Zero 1: cancela polo da planta ---
z1 = -0.8842;

% --- Zero 2: condição de ângulo em s* ---
% Polos efetivos após cancelamento: dois em s=0
phi_p1 = angle(s_star - 0);   % contribuição do polo 1
phi_p2 = angle(s_star - 0);   % contribuição do polo 2 (idêntico)

% Ângulo que z2 precisa contribuir
phi_z2_needed = pi + phi_p1 + phi_p2;  % condição: phi_z2 - (phi_p1+phi_p2) = 180°

% z2 é o ponto no eixo real tal que angle(s* - z2) = phi_z2_needed
% angle(sigma + jw - z2) = atan2(omega_d, sigma - z2) = phi_z2_needed
% => sigma - z2 = omega_d / tan(phi_z2_needed)
z2 = real(s_star) - imag(s_star) / tan(phi_z2_needed);
fprintf('z2 pela condição de ângulo = %.4f\n', z2);

% --- Monta C(s) com os zeros calculados ---
% C(s) = Kd*(s-z1)*(s-z2)/s
num_zeros = conv([1 -z1], [1 -z2]);   % polinômio (s-z1)(s-z2)

% Ganho K pela condição de módulo em s*
L_s = (polyval(num_zeros, s_star) / s_star) * ...
      (0.0526 / (s_star^2 + 0.8842*s_star));
K = 1 / abs(L_s);
fprintf('K mínimo = %.4f\n', K);

% Extrai Kd, Kp, Ki
Kd = K;
Kp = K * (-(z1 + z2));        % coef de s no numerador expandido * K
Ki = K * (z1 * z2);           % termo independente * K
fprintf('Kd=%.4f  Kp=%.4f  Ki=%.4f\n', Kd, Kp, Ki);

% --- Monta e verifica ---
C_s = tf(K * num_zeros, [1 0]);
L_loop = C_s * G_s;
H_z  = feedback(L_loop, 1);

figure;
rlocus(L_loop); hold on; grid on;

% Região de requisitos
ax = axis;
sigma_min = sigma;
zeta_ang  = acos(zeta);
patch([ax(1) sigma_min sigma_min ax(1)], [ax(3) ax(3) ax(4) ax(4)], ...
      'g', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
lx = abs(ax(1));
patch([0 -lx -lx], [0 lx*tan(zeta_ang) -lx*tan(zeta_ang)], ...
      'b', 'FaceAlpha', 0.1, 'EdgeColor', 'none');
plot([sigma_min sigma_min], ax(3:4), 'r--', 'LineWidth', 1.5);
plot([0 -lx], [0  lx*tan(zeta_ang)], 'k--', 'LineWidth', 1.5);
plot([0 -lx], [0 -lx*tan(zeta_ang)], 'k--', 'LineWidth', 1.5);
plot(real(s_star), imag(s_star), 'r*', 'MarkerSize', 14);

title('Root Locus com zeros pela condição de ângulo');
xlabel('Re(s)'); ylabel('Im(s)');

figure; step(H_z); grid on;
title('Resposta ao degrau');