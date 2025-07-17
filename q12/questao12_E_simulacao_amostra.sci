clc; clear; // Limpa console e variáveis

// Parâmetros da distribuição exponencial
lambda = 3;
true_mean = 1/lambda;

// Gerar amostra usando FDA inversa
n = 10000;
U = rand(n, 1);
amostra_fda = -log(1 - U)/lambda;

// Calcular média e variância amostral
media_amostral = mean(amostra_fda);
variancia_amostral = variance(amostra_fda);

// Exibir os resultados no console
disp("Média amostral: " + string(media_amostral));
disp("Variância amostral: " + string(variancia_amostral));

// Criar vetor de pontos para plotar a FDP teórica
x = linspace(0, max(amostra_fda), 200);
fdp_teorica = lambda * exp(-lambda * x);

// Plotar histograma normalizado e FDP teórica
scf();
histplot(30, amostra_fda, normalization=%t);  // normalizado para densidade
plot(x, fdp_teorica, 'r-', 'LineWidth', 2);

// Configurações do gráfico
title('Comparação: FDP Teórica vs Histograma da Amostra', 'fontsize', 3);
xlabel('Valores', 'fontsize', 2);
ylabel('Densidade de Probabilidade', 'fontsize', 2);
legend(['Histograma (n=10000)'; 'FDP Teórica (λ=3)']);
xgrid(1);
