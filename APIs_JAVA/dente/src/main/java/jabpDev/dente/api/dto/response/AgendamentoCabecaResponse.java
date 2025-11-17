package jabpDev.dente.api.dto.response;

import java.util.List;

public record AgendamentoCabecaResponse(
        String tipo,
        String inicio,
        String fim,
        Long total,
        Long realizados,
        Long pendentes,
        Long cancelados,
        List<RelatorioAgendamentoResponse> agendamentos
) { }

