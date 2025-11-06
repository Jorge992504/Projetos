# Menu principal no console

# main.py
import time
from core.cliente_dados import ClienteDados
from core.analisador import AnalisadorMercado


analisador = AnalisadorMercado()


def menu():
    while True:
        print(
            """
+++++++++++++++++++++++++++++++++++++++++++++++++++
                   Iniciando bot
+++++++++++++++++++++++++++++++++++++++++++++++++++
0 - Sair
1 - Analizar mercado
2 - Modo automatico (realizar operação cada 5 min)
+++++++++++++++++++++++++++++++++++++++++++++++++++

""")

        opcao = input("Escolha uma opção: ")
        if opcao == "1":
            analisar_mercado()
        elif opcao == "2":
            modo_automatico()
        elif opcao == "0":
            break
        else:
            print("Opção invalida")


def analisar_mercado():
    codigo = input("Informe o código do mini índice: ")
    if not codigo:
        print("Código obrigatório")
        analisar_mercado()
    else:
        cliente = ClienteDados(codigo)
        dados = cliente.buscar_dados()

        if not dados:
            print("Nenhum dado disponível")
            return

        print(f"\n📊 Fonte: {dados['fonte']}")
        print(f"💹 Ativo: {dados['ativo']}")
        print(f"💰 Preço atual: {dados['preco']:.2f}")
        print(f"📉 Variação: {dados['variacao']}%")
        print(f"🕒 Hora: {dados['hora']}")
        sinal = analisador.analisar(dados['preco'])
        print(f"📈 Análise: {sinal}\n")


def modo_automatico():
    print("\n🚀 Iniciando modo automático (atualiza a cada 5 min)...")
    try:
        while True:
            analisar_mercado()
            time.sleep(300)  # 5 minutos
    except KeyboardInterrupt:
        print("\n🛑 Modo automático encerrado.")


if __name__ == "__main__":
    menu()
