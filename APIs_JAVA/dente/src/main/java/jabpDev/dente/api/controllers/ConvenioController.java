package jabpDev.dente.api.controllers;


import jabpDev.dente.api.dto.request.RegistrarConvenioRequest;
import jabpDev.dente.api.dto.response.BuscarServicosDtoResponse;
import jabpDev.dente.api.dto.response.ListarConvenioResponse;
import jabpDev.dente.api.services.ConvenioService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/convenio")
public class ConvenioController {

    private final ConvenioService convenioService;

    @PostMapping("/incluir")
    public void incluirConvenio(@RequestBody RegistrarConvenioRequest body){
        convenioService.incluirConvenio(body);
    }

    @GetMapping("/buscar")
    public List<ListarConvenioResponse> buscarConvenios(){
        return convenioService.buscarConvenio();
    }

    @GetMapping("/busca/servicos")
    public List<BuscarServicosDtoResponse> buscaServicos(){
        return convenioService.buscarServicos();
    }
}
