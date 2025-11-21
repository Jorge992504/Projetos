package jabpDev.dente.api.dto.request;

public record RegistrarPagamentoRequest(
        Long agendamentoId,
        Long convenioId,
        String tipoPagamento,
        String status,
        Double valorCobrado,
        Double valorAtual,
        Double valorDesconto,
        boolean tratamentoFechado,
        Double valorLiquido,
        Float percentoDentista
) {
}
