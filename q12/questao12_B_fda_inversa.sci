// Questão 12 - Geração da amostra com FDA inversa
// 1. Definindo a distribuição alvo: Exponencial com lambda = 3
lambda = 3;
true_mean = 1/lambda;  // Média teórica

// 2. Método da FDA inversa para distribuição exponencial
function x = exponencial_inv(u, lambda)
    // FDA inversa da exponencial: F^-1(u) = -ln(1-u)/lambda
    x = -log(1 - u)/lambda;
endfunction

// Gerando 1000 observações uniformes
 n = 10000;
U = rand(n, 1);  // Gera números uniformes [0,1]
// Calculando estatísticas descritivas
function mostrar_estatisticas(amostra, nome)
    m = mean(amostra);
    dp = stdev(amostra);
    printf("\n%s:\n", nome);
    printf("Média amostral: %.4f (Teórica: %.4f)\n", m, true_mean);
    printf("Desvio padrão: %.4f\n", dp);
    printf("Mínimo: %.4f\n", min(amostra));
    printf("Máximo: %.4f\n", max(amostra));
endfunction
// Aplicando FDA inversa
amostra_fda = exponencial_inv(U, lambda);
subplot(1,2,1);
histplot(30, amostra_fda);
title("Amostras do Método FDA Inversa", "fontsize", 3);
xlabel("Valores");
ylabel("Frequência");
