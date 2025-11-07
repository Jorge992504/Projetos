package jabpDev.dente.api.dto.request;

public record NovoAgendamentoDtoRequest(
        String dataHora,
        String cpfPaciente,
        Long dentistaId,
        Long servicoId,
        String observacoes
) {
}
