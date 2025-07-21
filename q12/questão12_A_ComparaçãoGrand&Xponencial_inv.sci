// ==============================================
// GERADOR DE AMOSTRAS POR FDA INVERSA E GRAND
// ==============================================
clc; clear;  // Limpa console, variáveis

 //1. Definindo a distribuição alvo: Exponencial com lambda = 3
lambda = 3;
true_mean = 1/lambda;  // Média teórica

// 2. Método da FDA inversa para distribuição exponencial
function x = exponencial_inv(u, lambda)
    // FDA inversa da exponencial: F^-1(u) = -ln(1-u)/lambda
    x = -log(1 - u)/lambda;
endfunction

// Gerando 1000 observações uniformes
 n = 1000;
U = rand(n, 1);  // Gera números uniformes [0,1]

// Aplicando FDA inversa
amostra_fda = exponencial_inv(U, lambda);

// 3. Usando a função grand do Scilab para comparação
amostra_grand = grand(n, 1, "exp", 1/lambda);

// ==============================================
// ANÁLISE DOS RESULTADOS
// ==============================================

// Calculando estatísticas descritivas
function mostrar_estatisticas(amostra, nome)
    m = mean(amostra);
    dp = stdev(amostra);
    printf("\n%s:\n", nome);
    printf(" Média amostral: %.4f (Teórica: %.4f)\n", m, true_mean);
     printf(" Váriância:%.4f\n", dp*dp, true_mean);
    printf(" Desvio padrão: %.4f\n", dp);
    printf(" Mínimo: %.4f\n", min(amostra));
    printf(" Máximo: %.4f\n", max(amostra));
endfunction

mostrar_estatisticas(amostra_fda, "Método FDA Inversa");
mostrar_estatisticas(amostra_grand, "Função GRAND");

// ==============================================
// VISUALIZAÇÃO DOS RESULTADOS
// ==============================================

// Criando histogramas
subplot(1,2,1);
histplot(30, amostra_fda);
title("Método FDA Inversa", "fontsize", 3);
xlabel("Valores");
ylabel("Frequência");

subplot(1,2,2);
histplot(30, amostra_grand);
title("Função GRAND", "fontsize", 3);
xlabel("Valores");
ylabel("Frequência");


for i = 1:n
    valor_transformado = exponencial_inv(U(i), lambda);
    mprintf("U(%d) = %.4f → X = %.4f\n", i, U(i), valor_transformado);
end
