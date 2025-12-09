package jabpDev.dente.api.dto.response;

import jabpDev.dente.api.entitys.Empresa;

import java.time.LocalDate;

public record EmpresaDtoResponse(
        String foto,
        String nomeClinica,
        String emailClinica,
        String telefone,
        String endereco,
        String cnpj,
        LocalDate dataRegistro,
        Long filialCLinica,
        String plano
) {
}
