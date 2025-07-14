import tkinter as tk
import random
from tkinter import messagebox

# Classe que representa cada porta do jogo
class Porta:
    def __init__(self, canvas, x, id):
        self.canvas = canvas  # Canvas onde a porta será desenhada
        self.x = x            # Posição horizontal da porta
        self.id = id          # Identificador da porta (0, 1 ou 2)
        self.status = "fechada"  # Estado inicial da porta
        # Desenha o retângulo da porta no canvas
        self.rect = canvas.create_rectangle(x, 50, x+100, 200, fill='sienna', tags=f"porta{id}")
        # Adiciona o texto com o número da porta
        self.label = canvas.create_text(x+50, 210, text=f"Porta {id+1}", font=("Arial", 12), tags=f"porta{id}")
        self.objeto = None    # Guarda o emoji (prêmio ou bode) quando a porta é aberta

    # Método para abrir a porta e mostrar o conteúdo (prêmio ou bode)
    def abrir(self, conteudo):
        self.status = "aberta"
        self.canvas.itemconfig(self.rect, fill='white')  # Muda a cor da porta aberta
        emoji = "🎁" if conteudo == "premio" else "🐐"   # Escolhe o emoji
        if self.objeto:
            self.canvas.delete(self.objeto)              # Remove emoji anterior, se houver
        self.objeto = self.canvas.create_text(self.x+50, 120, text=emoji, font=("Arial", 32))

    # Método para resetar a porta (fechar e remover emoji)
    def reset(self):
        self.status = "fechada"
        self.canvas.itemconfig(self.rect, fill='sienna')
        if self.objeto:
            self.canvas.delete(self.objeto)
            self.objeto = None

# Classe principal da interface gráfica do Monty Hall
class MontyHallGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Problema de Monty Hall - Estilo PhET com Estatísticas")

        # Cria o canvas para desenhar as portas
        self.canvas = tk.Canvas(root, width=400, height=300, bg='lightblue')
        self.canvas.grid(row=0, column=0, rowspan=3)

        # Frame para mostrar as estatísticas
        self.estatisticas_frame = tk.Frame(root)
        self.estatisticas_frame.grid(row=0, column=1, padx=20)

        # Cria as 3 portas
        self.portas = [Porta(self.canvas, 40 + i*120, i) for i in range(3)]

        # Label de instrução para o usuário
        self.label = tk.Label(root, text="Escolha uma porta clicando nela!", font=("Arial", 14))
        self.label.grid(row=1, column=1)

        # Liga o clique do mouse ao método de escolha de porta
        self.canvas.bind("<Button-1>", self.clique_porta)

        # Estatísticas do jogo
        self.vitorias_troca = 0
        self.vitorias_manter = 0
        self.total_jogos = 0

        # Label para mostrar as estatísticas
        self.label_stats = tk.Label(self.estatisticas_frame, font=("Arial", 12), justify="left")
        self.label_stats.pack()
        self.atualizar_estatisticas()

        self.btns = []  # Guarda os botões de trocar/manter

        self.reiniciar_jogo()  # Inicia o primeiro jogo

    # Atualiza o painel de estatísticas
    def atualizar_estatisticas(self):
        self.label_stats.config(
            text=f"🏁 Estatísticas:\n\n"
                 f"🔁 Trocando: {self.vitorias_troca} vitórias\n"
                 f"✅ Mantendo: {self.vitorias_manter} vitórias\n"
                 f"🎲 Total de jogos: {self.total_jogos}"
        )

    # Reinicia o estado do jogo para uma nova rodada
    def reiniciar_jogo(self):
        self.escolhida = None  # Porta escolhida pelo usuário
        self.aberta = None     # Porta aberta pelo apresentador (bode)
        self.final = None      # Porta final escolhida pelo usuário
        self.premio = random.randint(0, 2)  # Sorteia onde está o prêmio
        self.estado = "escolha"             # Estado inicial: aguardando escolha

        for p in self.portas:
            p.reset()  # Fecha todas as portas

    # Método chamado quando o usuário clica em uma porta
    def clique_porta(self, event):
        if self.estado != "escolha":
            return  # Só permite escolher se estiver no estado correto

        for i, porta in enumerate(self.portas):
            if self.canvas.find_withtag(f"porta{i}"):
                coords = self.canvas.coords(porta.rect)
                # Verifica se o clique foi dentro da área da porta
                if coords[0] < event.x < coords[2] and coords[1] < event.y < coords[3]:
                    self.escolhida = i
                    self.revelar_bode()  # Revela uma porta com bode
                    return

    # Revela uma das portas que não foi escolhida e não tem o prêmio (mostra o bode)
    def revelar_bode(self):
        opcoes = [i for i in range(3) if i != self.escolhida and i != self.premio]
        self.aberta = random.choice(opcoes)
        self.portas[self.aberta].abrir("bode")
        self.estado = "troca"  # Agora o usuário pode trocar ou manter
        self.label.config(text="Você quer TROCAR ou MANTER?")
        self.add_botoes()      # Mostra os botões de decisão

    # Adiciona os botões para o usuário decidir trocar ou manter
    def add_botoes(self):
        btn_frame = tk.Frame(self.root)
        btn_frame.grid(row=2, column=1, pady=10)
        btn_trocar = tk.Button(btn_frame, text="🔁 Trocar", font=("Arial", 12), command=self.trocar)
        btn_manter = tk.Button(btn_frame, text="✅ Manter", font=("Arial", 12), command=self.manter)
        btn_trocar.grid(row=0, column=0, padx=10)
        btn_manter.grid(row=0, column=1, padx=10)
        self.btns = [btn_trocar, btn_manter, btn_frame]

    # Método chamado se o usuário decidir trocar de porta
    def trocar(self):
        # A porta final será a que não foi escolhida nem aberta
        self.final = [i for i in range(3) if i != self.escolhida and i != self.aberta][0]
        self.finalizar_jogo(trocou=True)

    # Método chamado se o usuário decidir manter a escolha inicial
    def manter(self):
        self.final = self.escolhida
        self.finalizar_jogo(trocou=False)

    # Finaliza o jogo, revela o resultado e atualiza as estatísticas
    def finalizar_jogo(self, trocou):
        conteudo = "premio" if self.final == self.premio else "bode"
        self.portas[self.final].abrir(conteudo)  # Mostra o que tem na porta final
        for btn in self.btns:
            btn.destroy()  # Remove os botões de decisão

        # Atualiza as estatísticas de vitória
        if self.final == self.premio:
            if trocou:
                self.vitorias_troca += 1
            else:
                self.vitorias_manter += 1
            resultado = "🎉 Você GANHOU o carro!"
        else:
            resultado = "🐐 Você encontrou um bode..."

        self.total_jogos += 1
        self.atualizar_estatisticas()
        self.label.config(text=resultado)

        # Após 1,2 segundos, pergunta se o usuário quer jogar novamente
        self.root.after(1200, self.perguntar_novamente)

    # Pergunta ao usuário se deseja jogar novamente
    def perguntar_novamente(self):
        if messagebox.askyesno("Jogar de novo?", "Deseja jogar novamente?"):
            self.reiniciar_jogo()
            self.label.config(text="Escolha uma porta clicando nela!")
        else:
            self.root.destroy()  # Fecha o programa

# Executa a interface gráfica se o arquivo for executado diretamente
if __name__ == "__main__":
    root = tk.Tk()
    app = MontyHallGUI(root)
    root.mainloop()
