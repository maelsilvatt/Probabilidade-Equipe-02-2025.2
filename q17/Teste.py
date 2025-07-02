import tkinter as tk
import random
from tkinter import messagebox

class Porta:
    def __init__(self, canvas, x, id):
        self.canvas = canvas
        self.x = x
        self.id = id
        self.status = "fechada"
        self.rect = canvas.create_rectangle(x, 50, x+100, 200, fill='sienna', tags=f"porta{id}")
        self.label = canvas.create_text(x+50, 210, text=f"Porta {id+1}", font=("Arial", 12), tags=f"porta{id}")
        self.objeto = None

    def abrir(self, conteudo):
        self.status = "aberta"
        self.canvas.itemconfig(self.rect, fill='white')
        emoji = "🎁" if conteudo == "premio" else "🐐"
        if self.objeto:
            self.canvas.delete(self.objeto)
        self.objeto = self.canvas.create_text(self.x+50, 120, text=emoji, font=("Arial", 32))

    def reset(self):
        self.status = "fechada"
        self.canvas.itemconfig(self.rect, fill='sienna')
        if self.objeto:
            self.canvas.delete(self.objeto)
            self.objeto = None

class MontyHallGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Problema de Monty Hall - Estilo PhET com Estatísticas")

        self.canvas = tk.Canvas(root, width=400, height=300, bg='lightblue')
        self.canvas.grid(row=0, column=0, rowspan=3)

        self.estatisticas_frame = tk.Frame(root)
        self.estatisticas_frame.grid(row=0, column=1, padx=20)

        self.portas = [Porta(self.canvas, 40 + i*120, i) for i in range(3)]

        self.label = tk.Label(root, text="Escolha uma porta clicando nela!", font=("Arial", 14))
        self.label.grid(row=1, column=1)

        self.canvas.bind("<Button-1>", self.clique_porta)

        self.vitorias_troca = 0
        self.vitorias_manter = 0
        self.total_jogos = 0

        self.label_stats = tk.Label(self.estatisticas_frame, font=("Arial", 12), justify="left")
        self.label_stats.pack()
        self.atualizar_estatisticas()

        self.btns = []

        self.reiniciar_jogo()

    def atualizar_estatisticas(self):
        self.label_stats.config(
            text=f"🏁 Estatísticas:\n\n"
                 f"🔁 Trocando: {self.vitorias_troca} vitórias\n"
                 f"✅ Mantendo: {self.vitorias_manter} vitórias\n"
                 f"🎲 Total de jogos: {self.total_jogos}"
        )

    def reiniciar_jogo(self):
        self.escolhida = None
        self.aberta = None
        self.final = None
        self.premio = random.randint(0, 2)
        self.estado = "escolha"

        for p in self.portas:
            p.reset()

    def clique_porta(self, event):
        if self.estado != "escolha":
            return

        for i, porta in enumerate(self.portas):
            if self.canvas.find_withtag(f"porta{i}"):
                coords = self.canvas.coords(porta.rect)
                if coords[0] < event.x < coords[2] and coords[1] < event.y < coords[3]:
                    self.escolhida = i
                    self.revelar_bode()
                    return

    def revelar_bode(self):
        opcoes = [i for i in range(3) if i != self.escolhida and i != self.premio]
        self.aberta = random.choice(opcoes)
        self.portas[self.aberta].abrir("bode")
        self.estado = "troca"
        self.label.config(text="Você quer TROCAR ou MANTER?")
        self.add_botoes()

    def add_botoes(self):
        btn_frame = tk.Frame(self.root)
        btn_frame.grid(row=2, column=1, pady=10)
        btn_trocar = tk.Button(btn_frame, text="🔁 Trocar", font=("Arial", 12), command=self.trocar)
        btn_manter = tk.Button(btn_frame, text="✅ Manter", font=("Arial", 12), command=self.manter)
        btn_trocar.grid(row=0, column=0, padx=10)
        btn_manter.grid(row=0, column=1, padx=10)
        self.btns = [btn_trocar, btn_manter, btn_frame]

    def trocar(self):
        self.final = [i for i in range(3) if i != self.escolhida and i != self.aberta][0]
        self.finalizar_jogo(trocou=True)

    def manter(self):
        self.final = self.escolhida
        self.finalizar_jogo(trocou=False)

    def finalizar_jogo(self, trocou):
        conteudo = "premio" if self.final == self.premio else "bode"
        self.portas[self.final].abrir(conteudo)
        for btn in self.btns:
            btn.destroy()

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

        self.root.after(1200, self.perguntar_novamente)

    def perguntar_novamente(self):
        if messagebox.askyesno("Jogar de novo?", "Deseja jogar novamente?"):
            self.reiniciar_jogo()
            self.label.config(text="Escolha uma porta clicando nela!")
        else:
            self.root.destroy()

# Executar GUI
if __name__ == "__main__":
    root = tk.Tk()
    app = MontyHallGUI(root)
    root.mainloop()
