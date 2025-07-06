// Questão 17 - Simulação do problema de Monty Hall

// 1. Parâmetros da Simulação
num_simulacoes = 50000;  // Número total de simulações a serem realizadas

// 2. Inicialização dos Contadores
vitorias_mantendo = 0;  // Contador para vitórias quando o participante escolhe MANTER a porta inicial
vitorias_trocando = 0;  // Contador para vitórias quando o participante escolhe TROCAR de porta

// 3. Loop Principal da Simulação
for i = 1:num_simulacoes
    
    // O prêmio é colocado aleatoriamente atrás de uma das 3 portas (1, 2 ou 3)
    porta_premiada = grand(1, 1, 'uin', 1, 3);
    
    // O participante faz sua escolha inicial, também aleatória
    escolha_inicial = grand(1, 1, 'uin', 1, 3);
    
    // --- Avaliação das Estratégias ---
    
    // Estratégia 1: MANTER a escolha
    // O participante ganha se a sua escolha inicial for a porta premiada.
    if escolha_inicial == porta_premiada then
        vitorias_mantendo = vitorias_mantendo + 1;
    end
    
    // Estratégia 2: TROCAR de porta
    // O participante ganha ao trocar SE a sua escolha inicial NÃO era a porta premiada.
    // Se a escolha inicial era errada, o apresentador é forçado a abrir a outra
    // porta vazia, deixando o prêmio na porta restante (para a qual o participante troca).
    if escolha_inicial <> porta_premiada then
        vitorias_trocando = vitorias_trocando + 1;
    end
    
end

// 4. Cálculo das Probabilidades (Frequências Relativas)
prob_manter = vitorias_mantendo / num_simulacoes;
prob_trocar = vitorias_trocando / num_simulacoes;

// 5. Exibição dos Resultados
clc;

printf("--- Resultados da Simulação de Monty Hall ---\n");
printf("Número total de jogos simulados: %d\n\n", num_simulacoes);

printf("Estratégia 1: Manter a Escolha Inicial\n");
printf("Vitórias: %d\n", vitorias_mantendo);
printf("Probabilidade (frequência relativa) de ganhar: %.4f (ou %.2f%%)\n\n", prob_manter, prob_manter * 100);

printf("Estratégia 2: Trocar de Porta\n");
printf("Vitórias: %d\n", vitorias_trocando);
printf("Probabilidade (frequência relativa) de ganhar: %.4f (ou %.2f%%)\n\n", prob_trocar, prob_trocar * 100);