package jabpDev.dente.api.dto.response;

public record ListarConvenioResponse(
        String parceiro,
        String tratamento,
        Double valor_pago
) {
}
