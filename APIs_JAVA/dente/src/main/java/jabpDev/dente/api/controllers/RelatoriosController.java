package jabpDev.dente.api.controllers;



import jabpDev.dente.api.dto.request.AddNovoRelatorioRequest;
import jabpDev.dente.api.dto.response.ListaRelatoriosDtoResponse;
import jabpDev.dente.api.dto.response.RelatorioClinicoProcedimentosResponse;
import jabpDev.dente.api.services.RelatoriosServices;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/relatorios")
public class RelatoriosController {
    private final RelatoriosServices relatoriosServices;

    @PostMapping("/add-descricao")
    public ResponseEntity<?> addNovoRelatorio(@RequestBody AddNovoRelatorioRequest relatorios){
       return relatoriosServices.addNovoRelatorio(relatorios);
    }

    @GetMapping("/busca-relatorios")
    public List<ListaRelatoriosDtoResponse> buscaTiposRelatorios(){
        return relatoriosServices.buscaTiposRelatorios();
    }

    @GetMapping("/clinicos/procedimentos")
    public List<RelatorioClinicoProcedimentosResponse> buscaProcedimentosMaisRealizados(@RequestParam String filtro){
        return relatoriosServices.buscaProcedimentosMaisRealizados(filtro);
    }

}
