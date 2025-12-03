package jabpDev.dente.api.dto.request;

import jakarta.persistence.Column;

import java.util.List;

public record RegistrarPrecosDtoRequest(
         double preco,
         String plano,
         double desconto,
         boolean promocao,
         Double precoPromocao,
         List<String> funcionalidades
) {
}
