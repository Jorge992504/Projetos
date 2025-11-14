package jabpDev.dente.api.dto.request;

import jabpDev.dente.api.dto.response.ListaRelatoriosDtoResponse;

import java.util.List;

public record AddNovoRelatorioRequest(boolean especifico , List<String> nmRelatorio) {
//    List<ListaRelatoriosDtoResponse>
}
