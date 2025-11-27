package mercado_pago.payment.dto;

import java.math.BigDecimal;

public record PaymentDTO(
        BigDecimal amount,
        String token,        // token do cartão gerado pelo Flutter
        String paymentMethod // ex: "visa", "master"
) {}
