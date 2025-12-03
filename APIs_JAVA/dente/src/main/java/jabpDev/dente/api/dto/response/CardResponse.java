package jabpDev.dente.api.dto.response;

import java.time.OffsetDateTime;

public record CardResponse(
        String status,
        String statusDetail,
        Long id,
        OffsetDateTime dateApproved,
        String paymentMethodId,
        String paymentTypeId
) {
}
