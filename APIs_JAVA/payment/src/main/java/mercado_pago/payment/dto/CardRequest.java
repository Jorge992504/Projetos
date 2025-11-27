package mercado_pago.payment.dto;

import java.math.BigDecimal;

public record CardRequest(
        BigDecimal amount,
        String token,
        String descricao,
        Integer pacelas,
        String paymentMethodId
) {
}
