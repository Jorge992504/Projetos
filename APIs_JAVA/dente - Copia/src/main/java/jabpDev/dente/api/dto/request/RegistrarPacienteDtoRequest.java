package jabpDev.dente.api.dto.request;

import jakarta.persistence.Column;

public record RegistrarPacienteDtoRequest(
        String nome,
        String email,
        String telefone,
        String endereco,
        String cpf,
        String rg
) {
}
