package jabpDev.ServicosPro.api.Dto.Response;

import jabpDev.ServicosPro.api.Entitys.Categorias;
import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;

import java.time.LocalDate;

public record ResponseUsuario(
        Long id,
        String nome,
        String email,
        String foto,
        String tipoUsuario,
        String tipoPessoa,
        LocalDate dataNascimento,
        String telefone,
        String endereco,
        Long categoriaPrestador,
        String nomeCategoria,
        Double avalicao,
        Integer qtdeServicos
) {
}
