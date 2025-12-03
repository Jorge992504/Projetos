package jabpDev.dente.api.dto.response;

public record PixResponse(
        String qrCodeBase64,
        String qrCode,
        Long paymentId
) {
}
