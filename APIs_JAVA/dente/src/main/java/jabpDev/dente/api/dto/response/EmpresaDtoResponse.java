package jabpDev.dente.api.dto.response;

import jabpDev.dente.api.entitys.Empresa;

public record EmpresaDtoResponse(
        String foto,
        String nomeClinica,
        String emailClinica,
        String telefone,
        String endereco,
        String cnpj
) {
}
