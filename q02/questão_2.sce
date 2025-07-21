// Questão 2 - Variável Exponencial λ = 3

// Parâmetros iniciais
lambda = 3;
media_teorica = 1 / lambda;
N = 10000; // Número de amostras

// -----------------------------
// a) Gera uma amostra de 10000 observações de Xi
figure(1);
Xi = grand(N, 1, "exp", media_teorica); // Scilab usa a média como parâmetro

// Histograma de Xi
clf();
histplot(50, Xi);
xtitle("a) Histograma de 10.000 observações da distribuição exponencial (λ = 3)", "Valor", "Frequência");

// -----------------------------
// b) Gera 10.000 amostras com n = 2, 5 e 50
Xn2 = grand(N, 2, "exp", media_teorica);
Xn5 = grand(N, 5, "exp", media_teorica);
Xn50 = grand(N, 50, "exp", media_teorica);

// -----------------------------
// c) Calcula X̄ (média amostral) para cada amostra
Xbar2 = mean(Xn2, 2);
Xbar5 = mean(Xn5, 2);
Xbar50 = mean(Xn50, 2);

// -----------------------------
// d) Histogramas das médias amostrais
figure(2);
clf();
subplot(3,1,1);
histplot(50, Xbar2);
xtitle("d) Histograma de X̄ para n = 2");

subplot(3,1,2);
histplot(50, Xbar5);
xtitle("Histograma de X̄ para n = 5");

subplot(3,1,3);
histplot(50, Xbar50);
xtitle("Histograma de X̄ para n = 50");

// -----------------------------
// e) Média e desvio padrão amostral
mean2 = mean(Xbar2);
std2 = stdev(Xbar2);

mean5 = mean(Xbar5);
std5 = stdev(Xbar5);

mean50 = mean(Xbar50);
std50 = stdev(Xbar50);

// Exibe os resultados
disp(" ");
disp("========== e) Médias e Desvios Padrão ==========");
disp("n = 2  -> Média: " + string(mean2) + " | Desvio padrão: " + string(std2));
disp("n = 5  -> Média: " + string(mean5) + " | Desvio padrão: " + string(std5));
disp("n = 50 -> Média: " + string(mean50) + " | Desvio padrão: " + string(std50));

// -----------------------------
// f) Conclusão teórica (manual)
// Você pode escrever a conclusão baseada nesses dados no relatório:
// - As médias se aproximam de 1/λ = 0.3333.
// - O desvio padrão diminui com o aumento de n.
// - A forma dos histogramas se aproxima da normal conforme n cresce (Teorema do Limite Central).

//Teorema do Limite Central (TLC):
//A média de amostras independentes de uma variável aleatória, com média e variância finitas, tende a seguir uma distribuição normal à medida que o tamanho da amostra nn aumenta.

//Conclusão com base nos resultados:

//A média amostral Xˉ se aproxima da média populacional μ=1/λ=0,333 à medida que nn aumenta.

//O desvio padrão de Xˉ diminui com o aumento de n, indicando menor variabilidade.

//Os histogramas mostram que, para n=50, a distribuição das médias se aproxima de uma curva normal, como previsto pelo TLC.
