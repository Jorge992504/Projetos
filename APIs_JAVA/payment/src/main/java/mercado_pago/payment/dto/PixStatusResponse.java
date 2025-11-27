package mercado_pago.payment.dto;

public record PixStatusResponse(
        String status,
        Long paymentId
) {
}
