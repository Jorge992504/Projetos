package jabpDev.dente.api.dto.request;

public record NovoAgendamentoDtoRequest(
        String dataHora,
        String cpfPaciente,
        String observacoes,
        String nomePaciente,
        String email,
        Long dentistaId,
        Long servicoId
) {
}