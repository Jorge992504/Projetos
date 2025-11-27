package mercado_pago.payment.dto;

import java.math.BigDecimal;

public record PixRequest(
        String descricao,
        BigDecimal valor
) {
}
