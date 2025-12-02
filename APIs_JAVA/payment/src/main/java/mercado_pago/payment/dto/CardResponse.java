package mercado_pago.payment.dto;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;

public record CardResponse(
        String status,
        String statusDetail,
        Long id,
        OffsetDateTime dateApproved,
        String paymentMethodId,
        String paymentTypeId
) {}