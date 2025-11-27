package jabpDev.dente.api.dto.response.sub_response;

public record ItemPagamentoMensalDtoResponse(
        String dataPagamento,
        String servico,
        Double valorRecebido,
        Double desconto
) {
}
