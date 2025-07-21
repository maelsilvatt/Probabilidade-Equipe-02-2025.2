import pandas as pd
import matplotlib.pyplot as plt

# Nome do arquivo CSV gerado pelo Scilab
ARQUIVO_CSV = 'q17/monty_hall_convergence.csv'
# Nome do arquivo de imagem que será salvo
ARQUIVO_GRAFICO = 'q17/convergencia_monty_hall.png'

# --- Leitura e Processamento dos Dados ---
try:
    # Lê o arquivo CSV usando pandas
    df = pd.read_csv(ARQUIVO_CSV)
except FileNotFoundError:
    print(f"Erro: O arquivo '{ARQUIVO_CSV}' não foi encontrado.")
    print("Por favor, execute o script Scilab primeiro e coloque o arquivo CSV no mesmo diretório.")
    exit()

# --- Geração do Gráfico ---

# Define o estilo do gráfico para uma melhor visualização
plt.style.use('seaborn-v0_8-whitegrid')

# Cria a figura e os eixos do gráfico
fig, ax = plt.subplots(figsize=(12, 7))

# Plota os dados da simulação
ax.plot(df['Iteracao'], df['Prob_Manter'], label='Prob. Manter Escolha', color='red', linewidth=1.5)
ax.plot(df['Iteracao'], df['Prob_Trocar'], label='Prob. Trocar de Porta', color='blue', linewidth=1.5)

# Plota as linhas dos valores teóricos esperados
# Valor esperado para manter = 1/3
ax.axhline(y=1/3, color='darkred', linestyle='--', label='Valor Teórico (1/3 ≈ 0.333)')
# Valor esperado para trocar = 2/3
ax.axhline(y=2/3, color='darkblue', linestyle='--', label='Valor Teórico (2/3 ≈ 0.667)')

# --- Configurações e Títulos do Gráfico ---
ax.set_title('Convergência das Probabilidades no Problema de Monty Hall', fontsize=16)
ax.set_xlabel('Número de Simulações (Iterações)', fontsize=12)
ax.set_ylabel('Probabilidade (Frequência Relativa)', fontsize=12)

# Define os limites dos eixos para uma melhor visualização
ax.set_xlim(1, len(df))
ax.set_ylim(0, 1)

# Adiciona a legenda
ax.legend(loc='best')

# Salva o gráfico em um arquivo de imagem
plt.savefig(ARQUIVO_GRAFICO, dpi=300)

# Exibe o gráfico (opcional, pode ser comentado se só quiser salvar o arquivo)
plt.show()

print(f"Gráfico de convergência salvo com sucesso como '{ARQUIVO_GRAFICO}'")