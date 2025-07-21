clc; clear; // Limpa console e variáveis

// Parâmetro da distribuição exponencial
lambda = 3;

// Cálculo da média (valor esperado) e variância populacional
media_teorica = 1 / lambda;
variancia_teorica = 1 / (lambda^2);

// Exibir resultados no console
disp("Média (valor esperado) populacional: " + string(media_teorica));
disp("Variância populacional: " + string(variancia_teorica));
