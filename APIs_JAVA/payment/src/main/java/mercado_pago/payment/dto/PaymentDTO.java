package mercado_pago.payment.dto;

import java.math.BigDecimal;

public record PaymentDTO(
        String cardNumber,
        String securityCode,
        Integer expirationMonth,
        Integer expirationYear,
        String cardholderName,
        String cardholderCpf
) {}
