package mercado_pago.payment.dto;

public record PixResponse(
        String qrCodeBase64,
        String qrCode,
        Long paymentId
) {}
