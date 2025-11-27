package jabpDev.dente.api.dto.response;

import jabpDev.dente.api.dto.response.sub_response.ItemPagamentoMensalDtoResponse;

import java.util.List;

public record RelatorioPagamentoMensalDtoResponse(
        String mes,
        Double valorTotal,
        List<ItemPagamentoMensalDtoResponse> itens
) {
}


