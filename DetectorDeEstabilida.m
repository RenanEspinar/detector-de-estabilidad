clc;
clear;
close all;

%% =========================
%  DEFINIR SISTEMA
% ==========================
s = tf('s');

% Ejemplo 1: estable
G = 1/((s+1)*(s+2)*(s+3));

% Ejemplo 2: marginalmente estable
% G = 1/(s^2 + 1);

% Ejemplo 3: inestable
% G = 1/(s-1);

% Ejemplo 4: tu motor (ejemplo)
% R = 2;
% J = 0.02;
% Kt = 0.1;
% L = 0.5;
% b = 0.01;
% Ke = 0.1;
% G = Kt / (L*J*s^2 + (R*J + L*b)*s + (R*b + Kt*Ke));


%% =========================
%  OBTENER POLOS
% ==========================
p = pole(G);

% Tolerancia numérica para decidir si Re(s) ~ 0
tol = 1e-6;

real_parts = real(p);

%% =========================
%  CLASIFICACIÓN DE ESTABILIDAD
% ==========================
if any(real_parts > tol)
    estabilidad = 'INESTABLE';
    colorTitulo = [0.85 0.15 0.15];   % rojo
    explicacion = 'Existe al menos un polo con parte real positiva.';
elseif any(abs(real_parts) <= tol)
    % Hay polos sobre el eje imaginario (o en 0)
    % Revisar si están repetidos
    % Si hay repetidos en eje imaginario/0, realmente es inestable
    p_axis = p(abs(real_parts) <= tol);
    repetido = false;

    for i = 1:length(p_axis)
        for j = i+1:length(p_axis)
            if abs(p_axis(i) - p_axis(j)) < 1e-5
                repetido = true;
            end
        end
    end

    if repetido
        estabilidad = 'INESTABLE';
        colorTitulo = [0.85 0.15 0.15];   % rojo
        explicacion = 'Hay polos repetidos sobre el eje imaginario o en cero.';
    else
        estabilidad = 'MARGINALMENTE ESTABLE';
        colorTitulo = [0.95 0.6 0.1];     % naranja
        explicacion = 'Hay polos simples sobre el eje imaginario o en cero.';
    end
else
    estabilidad = 'ESTABLE';
    colorTitulo = [0.1 0.6 0.2];         % verde
    explicacion = 'Todos los polos tienen parte real negativa.';
end

%% =========================
%  CREAR FIGURA BONITA
% ==========================
figure('Color','w','Position',[100 100 1100 650]);

% Líneas de referencia
xline(0,'k--','LineWidth',1.5); hold on;
yline(0,'k--','LineWidth',1.5);

% Graficar polos
for k = 1:length(p)
    if real(p(k)) > tol
        plot(real(p(k)), imag(p(k)), 'x', ...
            'MarkerSize', 16, 'LineWidth', 3, 'Color', [0.85 0.15 0.15]); % rojo
    elseif abs(real(p(k))) <= tol
        plot(real(p(k)), imag(p(k)), 'x', ...
            'MarkerSize', 16, 'LineWidth', 3, 'Color', [0.95 0.6 0.1]);   % naranja
    else
        plot(real(p(k)), imag(p(k)), 'x', ...
            'MarkerSize', 16, 'LineWidth', 3, 'Color', [0.1 0.6 0.2]);    % verde
    end
end

% Etiquetas de polos
for k = 1:length(p)
    txt = sprintf('  %.3f %+.3fi', real(p(k)), imag(p(k)));
    text(real(p(k)), imag(p(k)), txt, ...
        'FontSize', 11, 'FontWeight', 'bold', 'Color', [0.15 0.15 0.15]);
end

% Ajuste de ejes automático con margen
xvals = real(p);
yvals = imag(p);

xmin = min([xvals; -1]) - 1;
xmax = max([xvals;  1]) + 1;
ymin = min([yvals; -1]) - 1;
ymax = max([yvals;  1]) + 1;

if abs(ymax - ymin) < 2
    ymin = -2;
    ymax = 2;
end

xlim([xmin xmax]);
ylim([ymin ymax]);

grid on;
box on;
axis equal;

xlabel('Parte Real','FontSize',13,'FontWeight','bold');
ylabel('Parte Imaginaria','FontSize',13,'FontWeight','bold');
title(['Clasificación de estabilidad: ', estabilidad], ...
    'FontSize',18,'FontWeight','bold','Color',colorTitulo);

%% =========================
%  TEXTO EXPLICATIVO EN FIGURA
% ==========================
texto1 = ['Sistema: ', estabilidad];
texto2 = explicacion;
texto3 = 'Regla:';
texto4 = '• Re(s) < 0  -> Estable';
texto5 = '• Re(s) = 0  -> Marginalmente estable';
texto6 = '• Re(s) > 0  -> Inestable';

annotation('textbox',[0.67 0.60 0.28 0.25], ...
    'String',{texto1,' ',texto2,' ',texto3,texto4,texto5,texto6}, ...
    'FitBoxToText','on', ...
    'BackgroundColor',[0.97 0.97 0.97], ...
    'EdgeColor',[0.3 0.3 0.3], ...
    'FontSize',12, ...
    'FontWeight','bold');

%% =========================
%  MOSTRAR EN COMMAND WINDOW
% ==========================
disp('========================================');
disp('POLOS DEL SISTEMA:');
disp(p);
disp('----------------------------------------');
disp(['CLASIFICACION: ', estabilidad]);
disp(['EXPLICACION: ', explicacion]);
disp('========================================');