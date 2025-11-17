package jabpDev.dente.api.dto.response;

public record RelatorioAgendamentoResponse(
        String servico,
        String data,
        String hora,
        String status
) {
}
