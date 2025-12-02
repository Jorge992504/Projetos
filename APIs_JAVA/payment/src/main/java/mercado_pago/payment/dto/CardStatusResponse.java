package mercado_pago.payment.dto;

public record CardStatusResponse(
        String status,
        Long paymentId
) {
}
