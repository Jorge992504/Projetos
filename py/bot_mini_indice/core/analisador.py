# Lógica de análise técnica (médias móveis)

# analisador.py
class AnalisadorMercado:
    """
    Faz uma análise simples com base nos últimos preços recebidos.
    """

    def __init__(self):
        self.historico = []

    def analisar(self, preco_atual):
        self.historico.append(preco_atual)

        if len(self.historico) < 5:
            return "⏳ Aguardando mais dados..."

        if self.historico[-1] > self.historico[-5]:
            return "📈 Tendência de alta — possível compra"
        elif self.historico[-1] < self.historico[-5]:
            return "📉 Tendência de baixa — possível venda"
        else:
            return "➖ Mercado lateral — sem sinal claro"
