package jabpDev.dente.api.dto.response;

public record HistoricoAgendamentosResponse(
        String dataHora,
        String nomePaciente,
        String status,
        String servico,
        String atendimento
) {
}
