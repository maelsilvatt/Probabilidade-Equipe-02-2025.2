// --- Simulação de Monty Hall com Salvamento de Convergência (VERSÃO CORRIGIDA) ---

// 1. Parâmetros da Simulação
num_simulacoes = 50000;
nome_arquivo = "monty_hall_convergence.csv";

// 2. Inicialização dos Contadores e Vetores de Resultados
vitorias_mantendo = 0;
vitorias_trocando = 0;
resultados_convergencia = zeros(num_simulacoes, 3);

// 3. Loop Principal da Simulação
// Esta parte continua a mesma e está correta
for i = 1:num_simulacoes
    porta_premiada = grand(1, 1, 'uin', 1, 3);
    escolha_inicial = grand(1, 1, 'uin', 1, 3);
    
    if escolha_inicial == porta_premiada then
        vitorias_mantendo = vitorias_mantendo + 1;
    else
        vitorias_trocando = vitorias_trocando + 1;
    end
    
    prob_manter_atual = vitorias_mantendo / i;
    prob_trocar_atual = vitorias_trocando / i;
    
    resultados_convergencia(i, :) = [i, prob_manter_atual, prob_trocar_atual];
end

// ----------------------------------------------------------------------
// 4. Preparação e Salvamento do Arquivo CSV (MÉTODO CORRIGIDO E ROBUSTO)
// ----------------------------------------------------------------------

// Abrir o arquivo para escrita ('w' significa 'write')
fid = mopen(nome_arquivo, 'w');
if fid == -1 then
    error("ERRO: Não foi possível criar ou abrir o arquivo para escrita: " + nome_arquivo);
end

// Escrever o cabeçalho (a primeira linha do arquivo)
mfprintf(fid, 'Iteracao,Prob_Manter,Prob_Trocar\n');

// Usar um loop para escrever os dados, linha por linha.
// Este método é mais seguro e garante a formatação correta.
for k = 1:size(resultados_convergencia, 1) // Loop de 1 até 50000
    mfprintf(fid, '%d,%.6f,%.6f\n', resultados_convergencia(k, 1), resultados_convergencia(k, 2), resultados_convergencia(k, 3));
end

// Fechar o arquivo para salvar as alterações
mclose(fid);

// 5. Exibição da Conclusão
clc;
printf("Simulação concluída.\n");
printf("Os %d pontos de dados da convergência foram salvos corretamente em: %s\n", num_simulacoes, nome_arquivo);

// Exibe os resultados finais
prob_final_manter = vitorias_mantendo / num_simulacoes;
prob_final_trocar = vitorias_trocando / num_simulacoes;
printf("\n--- Resultados Finais ---\n");
printf("Probabilidade final de ganhar mantendo: %.4f (%.2f%%)\n", prob_final_manter, prob_final_manter * 100);
printf("Probabilidade final de ganhar trocando: %.4f (%.2f%%)\n", prob_final_trocar, prob_final_trocar * 100);