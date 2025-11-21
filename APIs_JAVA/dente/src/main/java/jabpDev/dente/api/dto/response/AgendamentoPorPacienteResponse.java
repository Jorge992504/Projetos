package jabpDev.dente.api.dto.response;

public record AgendamentoPorPacienteResponse(
        Long agendamentoId,
        String status,
        String pacienteNome,
        String servico,
        String datahorario,
        String observacoes,
        Long pacienteId,
        Float vl,
        Long servicoId
) {
}
