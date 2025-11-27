package jabpDev.dente.api.controllers;



import jabpDev.dente.api.dto.response.AgendamentoCabecaResponse;
import jabpDev.dente.api.dto.response.RelatorioClinicoProcedimentosResponse;
import jabpDev.dente.api.dto.response.RelatorioPagamentoMensalDtoResponse;
import jabpDev.dente.api.services.RelatoriosServices;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/relatorios")
public class RelatoriosController {
    private final RelatoriosServices relatoriosServices;

    @GetMapping("/clinicos/procedimentos")
    public List<RelatorioClinicoProcedimentosResponse> buscaProcedimentosMaisRealizados(@RequestParam String filtro){
        return relatoriosServices.buscaProcedimentosMaisRealizados(filtro);
    }

    @GetMapping("/agendamentos")
    public List<AgendamentoCabecaResponse> buscaRelatoriosAgendamentos(@RequestParam String filtro){
        return relatoriosServices.buscaRelatoriosAgendamentos(filtro);
    }

    @GetMapping("/financiero")
    public List<RelatorioPagamentoMensalDtoResponse> buscarelatoriosFinanciero(){
        return relatoriosServices.buscarelatoriosFinanciero();
    }

}
