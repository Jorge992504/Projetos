package jabpDev.ServicosPro.api.Dto.Request;



import io.swagger.v3.oas.annotations.media.Schema;

import java.time.LocalDate;

@Schema(description = "Recebe os dados do usuario enviados para o cadastro")
public record RequestUsuario(

        String nome,
        String email,
        String senha,
        String foto,
        String tipoUsuario,
        String tipoPessoa,
        String cpf_cnpj,
        LocalDate dataNascimento,
        String telefone,
        String endereco,
        Long categoriaPrestador,
        Boolean termosPolitica
) {
}
