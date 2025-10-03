package jabpdev.nahora.api.dto.response;

public record PromocoesDtoResponse(
        Long produtoId,
        String produtoImage,
        String produtoNome,
        String produtoAdicionalNome,
        Float produtoQuantidade,
        String produtoDescricao,
        String produtoAdicionalDescricaoQtde,
        Float produtoAdicionalQuantidade,
        String produtoDescricaoQtde,
        Long promocaoId,
        Long produtoAdicionalId,
        Double precoPromocao,
        Double precoVariacao
) {
}

