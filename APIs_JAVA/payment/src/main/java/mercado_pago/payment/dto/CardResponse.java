package mercado_pago.payment.dto;

public record CardResponse(
        String status,
        Long paymentId
) {}
