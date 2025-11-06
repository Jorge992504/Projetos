package jabpDev.dente.api.dto.response;

import jabpDev.dente.api.dto.response.sub_response.DentistasDtoResponse;
import jabpDev.dente.api.dto.response.sub_response.ServicosDtoResponse;

import java.util.List;

public record ServicosDentistasDtoResponse(
        List<ServicosDtoResponse> servicos,
        List<DentistasDtoResponse> dentistas
) {
}
