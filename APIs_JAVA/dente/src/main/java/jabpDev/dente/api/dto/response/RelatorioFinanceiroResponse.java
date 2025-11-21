package jabpDev.dente.api.dto.response;

import lombok.Data;
import java.util.List;

@Data
public class RelatorioFinanceiroResponse {

    private Cabecalho cabecalho;
    private List<ItemDetalhe> detalhes;

    @Data
    public static class Cabecalho {
        private String periodo;
        private Double valorTotal;
    }

    @Data
    public static class ItemDetalhe {
        private String descricao; // dentista, convenio, serviço, dia, etc
        private Double valor;
    }
}
