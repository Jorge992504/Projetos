package jabpDev.dente.api.dto.request;

import org.springframework.web.multipart.MultipartFile;

public record RegistrarEmpresaDtoRequest(
        String foto,
        String nomeClinica,
        String emailClinica,
        String telefone,
        String endereco,
        String passowrd,
        String cnpj

) {
}
