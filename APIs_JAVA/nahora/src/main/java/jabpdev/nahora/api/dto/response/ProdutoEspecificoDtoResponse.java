package jabpdev.nahora.api.dto.response;

import java.util.List;

public record ProdutoEspecificoDtoResponse(
        Long produtoId,
        String produtoImage,
        String produtoNome,
        Float produtoQuantidade,
        String produtoDescricao,
        String produtoDescricaoQtde,
        Double precoVariacao
) {
}
