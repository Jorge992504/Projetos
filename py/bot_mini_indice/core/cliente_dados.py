# Conexão com a API de dados (Yahoo Finance)

import yfinance as yf
import requests
from datetime import datetime


class ClienteDados:
    def __init__(self, mini_indice):
        self.codigo_clear = mini_indice.upper()
        self.url_clear = f"https://cotacao.clear.com.br/api/v1/quotes/{self.codigo_clear}"

    def buscar_dados(self):
        # 1️⃣ Tenta buscar na Clear
        try:
            response = requests.get(self.url_clear, timeout=5)
            if response.status_code == 200:
                data = response.json()
                return {
                    "fonte": "Clear",
                    "ativo": self.codigo_clear,
                    "preco": float(data["lastPrice"]),
                    "variacao": float(data["changePercent"]),
                    "hora": datetime.now().strftime("%H:%M:%S")
                }
        except Exception as e:
            print("⚠️ Falha ao conectar com Clear, tentando Yahoo...")

        # 2️⃣ Tenta buscar no Yahoo Finance
        try:
            ticker = f"^BVSP" if self.codigo_clear == "BVSP" else f"{self.codigo_clear}"
            dados = yf.download(ticker, period="1d", interval="1m")
            if not dados.empty:
                preco = float(dados["Close"].iloc[-1])
                preco_anterior = float(dados["Open"].iloc[0])
                variacao = round(
                    ((preco - preco_anterior) / preco_anterior) * 100, 2)
                return {
                    "fonte": "Yahoo Finance",
                    "ativo": self.codigo_clear,
                    "preco": preco,
                    "variacao": variacao,
                    "hora": datetime.now().strftime("%H:%M:%S")
                }
            else:
                print("❌ Yahoo Finance não retornou dados.")
                return None
        except Exception as e:
            print(f"❌ Erro Yahoo: {e}")
            return None
