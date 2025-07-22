// Questão 12 - Comparação entre fdp teórica e histograma

clc; clear; // Limpa console, variáveis 

// Parâmetros da distribuição exponencial
lambda = 3;
true_mean = 1/lambda;

// Gerar amostra usando FDA inversa (como no item anterior)
n = 1000;
U = rand(n, 1);
amostra_fda = -log(1 - U)/lambda;

// Criar vetor de pontos para plotar a PDF teórica
x = linspace(0, max(amostra_fda), 200);
pdf_teorica = lambda * exp(-lambda * x);

// Plotar histograma normalizado e PDF teórica
scf();
histplot(30, amostra_fda, normalization=%t);  // normalization=%t para densidade
plot(x, pdf_teorica, 'r-', 'LineWidth', 2);

// Configurações do gráfico
title('Comparação: PDF Teórica vs Histograma da Amostra', 'fontsize', 3);
xlabel('Valores', 'fontsize', 2);
ylabel('Densidade de Probabilidade', 'fontsize', 2);
legend(['Histograma (n=10000)'; 'PDF Teórica (λ=3)']);
xgrid(1);
