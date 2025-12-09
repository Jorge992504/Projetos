package jabpDev.dente.api.dto.request;

import java.math.BigDecimal;

public record PagamentoStatusRequest(
        Long paymentId,
        String token,
        String periodo,
        String tipoPlano,
        BigDecimal valor
) {
}
