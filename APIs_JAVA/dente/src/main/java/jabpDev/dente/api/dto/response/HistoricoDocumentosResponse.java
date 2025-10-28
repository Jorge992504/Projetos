package jabpDev.dente.api.dto.response;

import java.io.File;
import java.util.List;

public record HistoricoDocumentosResponse(
        String data,
        List<File> arquivos
) {
}
