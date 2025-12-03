package jabpDev.dente.api.dto.request;

import java.math.BigDecimal;

public record PixRequest(
        String descricao,
        BigDecimal valor,
        String email,
        String name,
        String cnpj
) {
}
