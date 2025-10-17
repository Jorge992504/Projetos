package jabpDev.dente.api.dto.response;

public record BuscaDentistasDtoResponse(
        String nome,
        String email,
        String cro,
        String telefone,
        boolean ativo
) {
}
