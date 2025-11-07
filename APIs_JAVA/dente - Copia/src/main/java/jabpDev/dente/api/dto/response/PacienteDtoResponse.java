package jabpDev.dente.api.dto.response;

public record PacienteDtoResponse(
        String nome,
        String email,
        String telefone,
        String cpf
) {
}
