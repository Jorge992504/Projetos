package mercado_pago.payment.dto;

import java.math.BigDecimal;

public record CardRequest(
        String cardToken
) {
}
