package jabpDev.ServicosPro.api.Dto.Response;

public record ResponseUsuarioPrestador(
        Long usuarioId,
        String usuarioNome,
        Long categoriaId,
        String categoriaNome,
        Double avaliacao,
        String foto
) {
}
