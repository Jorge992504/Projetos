package jabpDev.dente.api.dto.request;

import java.math.BigDecimal;

public record CardRequest(
        BigDecimal amount,
        String cardToken,
        String descricao,
        Integer parcelas,
        String paymentMethodId,
        String email,
        String name,
        String cpf
) {
}
