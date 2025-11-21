package jabpDev.dente.api.dto.request;

public record RegistrarConvenioRequest(
        String parceiro,
        Long tratamento,
        double valorPago
) {
}
