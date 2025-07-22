clc; clear; // Limpa console e variáveis

// Parâmetros da distribuição exponencial
lambda = 3;
true_mean = 1/lambda;

// Gerar amostra usando FDA inversa
n = 1000;
U = rand(n, 1);
amostra_fda = -log(1 - U)/lambda;

// Calcular média e variância amostral
media_amostral = mean(amostra_fda);
variancia_amostral = variance(amostra_fda);

// Exibir os resultados no console
disp("Média amostral: " + string(media_amostral));
disp("Variância amostral: " + string(variancia_amostral));
