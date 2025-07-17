// --- Simulação do Problema de Monty Hall com Registro de Convergência ---

// 1. Definição dos parâmetros
num_simulacoes = 50000;
nome_arquivo = "monty_hall_convergence.csv";

// 2. Inicialização dos contadores e da matriz para armazenar os resultados
vitorias_mantendo = 0;
vitorias_trocando = 0;
resultados_convergencia = zeros(num_simulacoes, 3);

// 3. Loop principal da simulação
for i = 1:num_simulacoes
    porta_premiada = grand(1, 1, 'uin', 1, 3);      // Porta com o prêmio
    escolha_inicial = grand(1, 1, 'uin', 1, 3);     // Escolha do participante

    // Verifica se ganharíamos mantendo ou trocando a escolha
    if escolha_inicial == porta_premiada then
        vitorias_mantendo = vitorias_mantendo + 1;
    else
        vitorias_trocando = vitorias_trocando + 1;
    end

    // Calcula as probabilidades acumuladas até o momento
    prob_manter_atual = vitorias_mantendo / i;
    prob_trocar_atual = vitorias_trocando / i;

    // Armazena os dados de convergência
    resultados_convergencia(i, :) = [i, prob_manter_atual, prob_trocar_atual];
end

// 4. Salvamento dos resultados em arquivo CSV
fid = mopen(nome_arquivo, 'w');
if fid == -1 then
    error("ERRO: Não foi possível criar ou abrir o arquivo para escrita: " + nome_arquivo);
end

// Escreve o cabeçalho do CSV
mfprintf(fid, 'Iteracao,Prob_Manter,Prob_Trocar\n');

// Grava os dados linha por linha
for k = 1:size(resultados_convergencia, 1)
    mfprintf(fid, '%d,%.6f,%.6f\n', resultados_convergencia(k, 1), resultados_convergencia(k, 2), resultados_convergencia(k, 3));
end

// Fecha o arquivo
mclose(fid);

// 5. Exibição dos resultados finais
clc;
printf("Simulação concluída.\n");
printf("Resultados salvos em: %s (%d registros)\n", nome_arquivo, num_simulacoes);

// Calcula e exibe as probabilidades finais
prob_final_manter = vitorias_mantendo / num_simulacoes;
prob_final_trocar = vitorias_trocando / num_simulacoes;
printf("\n--- Resultados Finais ---\n");
printf("Probabilidade final ao manter a escolha: %.4f (%.2f%%)\n", prob_final_manter, prob_final_manter * 100);
printf("Probabilidade final ao trocar de porta: %.4f (%.2f%%)\n", prob_final_trocar, prob_final_trocar * 100);
